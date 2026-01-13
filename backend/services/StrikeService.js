const strikes = {};

const MAX_STRIKES = 3;

function addStrike(username) {
  if (!strikes[username]) {
    strikes[username] = 0;
  }

  strikes[username] += 1;

  console.log(`⚠️ Strike added to ${username}: ${strikes[username]}`);

  return strikes[username];
}

function isUserBlocked(username) {
  return strikes[username] >= MAX_STRIKES;
}

function getStrikeCount(username) {
  return strikes[username] || 0;
}

module.exports = {
  addStrike,
  isUserBlocked,
  getStrikeCount
};
