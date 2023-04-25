const net = require("net");

const port = 7000;
const host = "192.168.195.52";

const server = net.createServer();

server.listen(port, host, () => {
  console.log(`[SERVER] Server started on port ${port}`);
});

server.on("connection", (socket) => {
  console.log("[SERVER] New client connected.");
  
  socket.on("data", (data) => {
    console.log("[SERVER] Recieved data from client.");
    console.log(data.toString());
  });

  socket.on("timeout", () => {
    console.log("[SERVER] Client timed out.");
  });

  socket.on("disconnect", () => {
    console.log("[SERVER] Client disconnected.");
  });
});