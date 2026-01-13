require("dotenv").config();

const express = require("express");
const cors = require("cors");
const net = require("net");

const moderationRoutes = require("./routes/moderation");
const alertRoutes = require("./routes/alerts");
const childRoutes = require("./routes/children");

const app = express();
app.use(cors());
app.use(express.json());

app.use("/api/moderation", moderationRoutes);
app.use("/api/alerts", alertRoutes);
app.use("/api/children", childRoutes);

/* ================================
   HTTP API (Dashboard / Admin)
================================ */
const HTTP_PORT = 3000;
app.listen(HTTP_PORT, () => {
  console.log(`SafeLuanti HTTP API running on port ${HTTP_PORT}`);
});

//   TCP IPC Server (Luanti)

const TCP_PORT = 5050;

const tcpServer = net.createServer((socket) => {
  socket.on("data", async (data) => {
    try {
      const message = data.toString().trim();
      const payload = JSON.parse(message);

      const decision = moderateMessage(payload);

      socket.write(JSON.stringify(decision) + "\n");
    } catch (err) {
      socket.write(JSON.stringify({
        decision: "ALLOW",
        reason: "Backend error"
      }) + "\n");
    } finally {
      socket.end();
    }
  });
});

tcpServer.listen(TCP_PORT, "127.0.0.1", () => {
  console.log(`SafeLuanti TCP IPC listening on port ${TCP_PORT}`);
});

/////
function moderateMessage({ sender, message, childId }) {
  const banned = ["hack", "cheat", "kill yourself"];

  for (const word of banned) {
    if (message?.toLowerCase().includes(word)) {
      return {
        decision: "BLOCK",
        reason: `Detected banned word: ${word}`
      };
    }
  }

  return {
    decision: "ALLOW",
    reason: "Clean message"
  };
}
