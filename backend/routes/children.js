const express = require("express");
const router = express.Router();

// Temporary in-memory storage
const children = [];

/**
 * POST /api/children
 * Link a child account
 */
router.post("/", (req, res) => {
  const { name, username, age, parent } = req.body;

  if (!name || !username || !age) {
    return res.status(400).json({ error: "Invalid child data" });
  }

  const child = {
    id: Date.now(),
    name,
    username,
    age,
    parent,
    createdAt: new Date()
  };

  children.push(child);
  res.status(201).json(child);
});

/**
 * GET /api/children
 * Get all linked children
 */
router.get("/", (req, res) => {
  res.json(children);
});

module.exports = router;
