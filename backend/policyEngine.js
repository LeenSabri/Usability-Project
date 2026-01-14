function applyPolicy(openai, perspective) {
  // Hard parental blocks
  if (
    openai.categories.sexual ||
    openai.categories.hate ||
    openai.categories.violence
  ) {
    return "BLOCK";
  }

  // Severe behavioral risk → FLAG
  if (
    perspective.toxicity > 0.85 ||
    perspective.threat > 0.70 ||
    perspective.insult > 0.80
  ) {
    return "FLAG";
  }

  // OpenAI flagged but not explicit → FLAG
  if (openai.flagged) {
    return "FLAG";
  }

  return "ALLOW";
}

module.exports = { applyPolicy };
