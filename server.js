// Minimal WebRTC signaling server.
// It does NOT see any video. It only relays the small "let's connect" messages
// between the two phones so their browsers can set up a direct stream.

const express = require("express");
const http = require("http");
const { WebSocketServer } = require("ws");
const path = require("path");

const app = express();
app.use(express.static(path.join(__dirname, "public")));

const server = http.createServer(app);
const wss = new WebSocketServer({ server });

// rooms: code -> { broadcaster: ws|null, viewer: ws|null }
const rooms = new Map();

function send(ws, obj) {
  if (ws && ws.readyState === ws.OPEN) ws.send(JSON.stringify(obj));
}

wss.on("connection", (ws) => {
  ws.room = null;
  ws.role = null;

  ws.on("message", (raw) => {
    let msg;
    try { msg = JSON.parse(raw); } catch { return; }

    // join: { type:"join", room:"ABC123", role:"broadcaster"|"viewer" }
    if (msg.type === "join") {
      const code = String(msg.room || "").trim().toUpperCase();
      if (!code) return send(ws, { type: "error", reason: "missing room code" });

      const room = rooms.get(code) || { broadcaster: null, viewer: null };
      if (room[msg.role] && room[msg.role].readyState === ws.OPEN) {
        return send(ws, { type: "error", reason: `a ${msg.role} is already in this room` });
      }
      room[msg.role] = ws;
      rooms.set(code, room);
      ws.room = code;
      ws.role = msg.role;

      // Tell both sides whether their partner is present.
      if (room.broadcaster && room.viewer) {
        send(room.broadcaster, { type: "peer-ready" }); // broadcaster should make the offer
        send(room.viewer, { type: "peer-ready" });
      }
      return;
    }

    // Relay signaling (offer / answer / ice) to the OTHER party in the room.
    if (!ws.room) return;
    const room = rooms.get(ws.room);
    if (!room) return;
    const other = ws.role === "broadcaster" ? room.viewer : room.broadcaster;
    if (["offer", "answer", "ice"].includes(msg.type)) {
      send(other, msg);
    }
  });

  ws.on("close", () => {
    if (!ws.room) return;
    const room = rooms.get(ws.room);
    if (!room) return;
    if (room[ws.role] === ws) room[ws.role] = null;
    const other = ws.role === "broadcaster" ? room.viewer : room.broadcaster;
    send(other, { type: "peer-left" });
    if (!room.broadcaster && !room.viewer) rooms.delete(ws.room);
  });
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => console.log(`CamPeek running on port ${PORT}`));
