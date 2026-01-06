const express = require("express");
const router = express.Router();

const { saveIncident } = require("../services/IncidentService");
const { addStrike, isUserBlocked } = require("../services/StrikeService");
const { notifyParent } = require("../services/NotificationService");

const { moderateText } = require("../services/openAiModeration");
const { analyzeText } = require("../services/perspectiveModeration");
const { applyPolicy } = require("../PolicyEngine");

// POST /api/moderation/inspect
router.post("/inspect", async (req, res) => {
  try {
    const { sender, message, childId } = req.body;

    // Run OpenAI moderation
    const openaiResult = await moderateText(message);

    // Run Perspective AI
    const perspectiveResult = await analyzeText(message);

    // Apply unified policy
    const decision = applyPolicy(openaiResult, perspectiveResult);

    // FLAG → save incident, notify parent, strike user
    if (decision === "FLAG") {
      const incident = saveIncident({
        sender,
        childId,
        message,
        decision
      });

      addStrike(sender);
      notifyParent(childId, incident);

      if (isUserBlocked(sender)) {
        console.log(`⛔ User ${sender} reached max strikes and is blocked`);
      }
    }

    // Respond to Luanti
    res.json({
      decision,           // ALLOW | FLAG | BLOCK
      censor: decision === "BLOCK",
      blockSender: isUserBlocked(sender)
    });

  } catch (err) {
    console.error("Moderation error:", err);
    res.status(500).json({ error: "Moderation failed" });
  }
});

module.exports = router;
