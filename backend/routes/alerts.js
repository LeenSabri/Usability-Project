const express = require("express");
const router = express.Router();

// Temporary in-memory storage (replace with DB later)
const alerts = [];

/**
 * GET /api/alerts
 * Returns all alerts
 */
router.get("/", (req, res) => {
  res.json(alerts);
});

/**
 * POST /api/alerts
 * Save a new alert
 */
router.post("/", (req, res) => {
  const { player, message, decision, scores } = req.body;

  if (!player || !message || !decision) {
    return res.status(400).json({ error: "Invalid alert data" });
  }

  const alert = {
    id: Date.now(),
    player,
    message,
    decision,
    scores,
    createdAt: new Date()
  };

  alerts.push(alert);
  res.status(201).json(alert);
});

module.exports = router;
