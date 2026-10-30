# CamPeek — one-way camera link

Your friend's phone (Mumbai) shares its camera; you (Bangalore) watch. His browser
asks camera permission and he taps **Allow**. The server never sees the video — the
stream goes phone-to-phone directly.

## Files
- `server.js` — signaling server (relays connection messages only)
- `public/index.html` — pick a room code + role
- `public/broadcaster.html` — the phone being watched
- `public/viewer.html` — your screen

## Run locally (to test)
```
npm install
npm start
```
Open http://localhost:3000. Note: camera access needs **HTTPS** on a real phone, so
local testing across two phones won't work without deploying. Deploy first (below).

## Deploy free (Render)
1. Put these files in a GitHub repo.
2. Go to render.com → New → Web Service → connect the repo.
3. Build command: `npm install` — Start command: `npm start`.
4. Render gives you an HTTPS URL like `https://campeek.onrender.com`.

## Use it
1. You both open the Render URL.
2. Type the **same room code** (e.g. `MUMBAI42`).
3. Your friend taps **Share camera** → Allow. You tap **Watch camera**.
4. The stream appears on your screen.

## If it won't connect (both on mobile data)
Phone-to-phone across different mobile networks sometimes needs a TURN relay.
Get free TURN credentials (e.g. metered.ca free tier) and paste the server block
into the `iceServers` array in **both** `broadcaster.html` and `viewer.html`:
```js
{ urls: "turn:YOUR_TURN_HOST:3478", username: "USER", credential: "PASS" }
```

## Note
This works because the person whose camera is shared grants permission on their own
device each time. Keep it that way — that consent is what makes it legitimate.
