const express = require("express");
const { moderateText } = require("../services/openaiModeration");
const { analyzeText } = require("../services/perspectiveModeration");
const { applyPolicy } = require("../policyEngine");

const router = express.Router();

router.post("/chat", async (req, res) => {
  const { player, message } = req.body;

  if (!player || !message) {
    return res.status(400).json({ error: "Invalid payload" });
  }

  try {
    const openaiResult = await moderateText(message);
    const perspectiveResult = await analyzeText(message);

    const decision = applyPolicy(openaiResult, perspectiveResult);

    res.json({
      player,
      message,
      decision,
      openai: {
        flagged: openaiResult.flagged,
        categories: openaiResult.categories
      },
      perspective: perspectiveResult
    });
  } catch (error) {
    console.error("Moderation error:", error);
    res.status(500).json({ error: "Moderation failed" });
  }
});

module.exports = router;
