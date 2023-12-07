const express = require("express");
const bodyParser = require("body-parser");
const bcrypt = require("bcrypt");
const cors = require("cors");
const jwt = require("jsonwebtoken");
const dotenv = require("dotenv");
const mysql = require("mysql2");

dotenv.config();
const app = express();
app.use(cors());
app.use(bodyParser.json());

const secretKey = process.env.SECRET_KEY;
const port = process.env.PORT;

// MySQL database connection
const db = mysql.createConnection({
  host: process.env.HOST,
  user: process.env.USER,
  password: process.env.PASSWORD,
  database: process.env.DATABASE,
});

db.connect((err) => {
  if (err) {
    console.error("Error connecting to MySQL database:", err);
  } else {
    console.log("Connected to MySQL database");
  }
});

// Signup API
app.post("/signup", async (req, res) => {
  const { username, email, password } = req.body;

  // Hash the password before storing it
  const hashedPassword = await bcrypt.hash(password, 10);

  // Check if the username or email already exists
  const checkExistingUserQuery =
    "SELECT * FROM users WHERE username = ? OR email = ?";
  db.query(checkExistingUserQuery, [username, email], async (err, results) => {
    if (err) {
      console.error("Error executing query:", err);
      res.status(500).json({ error: "Internal Server Error" });
    } else if (results.length > 0) {
      // User with the given username or email already exists
      res.status(400).json({ error: "Username or email already in use" });
    } else {
      // User does not exist, proceed with registration
      const insertUserQuery =
        "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
      db.query(insertUserQuery, [username, email, hashedPassword], (err) => {
        if (err) {
          console.error("Error executing query:", err);
          res.status(500).json({ error: "Internal Server Error" });
        } else {
          const token = jwt.sign({ username, email }, secretKey, {
            expiresIn: "1h",
          });
          res.status(201).json({
            token: token,
            username: username,
            email: email,
            message: "User registered successfully",
          });
        }
      });
    }
  });
});


// Signin API
app.post("/signin", async (req, res) => {
    const { email, password } = req.body;
  
    // Retrieve hashed password from the database
    const getUserQuery = "SELECT * FROM users WHERE email = ?";
    db.query(getUserQuery, [email], async (err, results) => {
      if (err) {
        console.error("Error executing query:", err);
        res.status(500).json({ error: "Internal Server Error" });
      } else if (results.length === 0) {
        // User not found
        res.status(401).json({ error: "Invalid credentials" });
      } else {
        // Compare hashed password with the provided password
        const hashedPassword = results[0].password;
        const passwordMatch = await bcrypt.compare(password, hashedPassword);
  
        if (passwordMatch) {
          const token = jwt.sign(
            { username: results[0].username, email },
            secretKey,
            { expiresIn: "1h" }
          );
          res.status(200).json({
            token: token,
            username: results[0].username,
            email: email,
            message: "Login successful",
          });
        } else {
          res.status(401).json({ error: "Invalid credentials" });
        }
      }
    });
  });

const authenticateToken = (req, res, next) => {
  const token = req.header("Authorization");
  if (!token) return res.status(401).json({ error: "Unauthorized" });
  jwt.verify(token, secretKey, (err, user) => {
    if (err) return res.status(403).json({ error: "Invalid token" });
    req.user = user;
  });
  next();
};

app.get("/getme", authenticateToken, (req, res) => {
  const { username, email } = req.user;
  res.json({ username, email });
});

// Start server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
