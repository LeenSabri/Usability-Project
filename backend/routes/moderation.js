const express = require("express");
const { moderateText } = require("../services/openaiModeration");
const { analyzeText } = require("../services/perspectiveModeration");
const { applyPolicy } = require("../services/policyEngine");

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
      decision,
      openai: {
        flagged: openaiResult.flagged,
        categories: openaiResult.categories
      },
      perspective: perspectiveResult
    });

  } catch (error) {
    console.error(error);
    res.status(500).json({ decision: "ALLOW" });
  }
});

module.exports = router;
