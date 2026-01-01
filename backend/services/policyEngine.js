function applyPolicy(openai, perspective) {
  if (
    openai.categories.sexual ||
    openai.categories.hate ||
    openai.categories.violence
  ) {
    return "BLOCK";
  }

  if (
    perspective.toxicity > 0.85 ||
    perspective.threat > 0.70 ||
    perspective.insult > 0.80
  ) {
    return "FLAG";
  }

  if (openai.flagged) {
    return "FLAG";
  }

  return "ALLOW";
}

module.exports = { applyPolicy };
