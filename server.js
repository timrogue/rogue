(function() {
  "use strict";
  var app, clients, fs, handler, io;

  process.title = 'rogue';

  clients = {};

  handler = function(req, res) {
    return fs.readFile(__dirname + req.url, function(err, data) {
      if (err) {
        res.writeHead(500);
        return res.end(__dirname + req.url);
      }
      res.writeHead(200);
      return res.end(data);
    });
  };

  app = require('http').createServer(handler);

  io = require('socket.io').listen(app);

  fs = require('fs');

  app.listen(1337);

  io.sockets.on('connection', function(socket) {
    var client, uid, userId;
    console.log((new Date()) + ' Connection from origin.');
    userId = "" + (Math.floor(Math.random() * 65368) + Math.floor(Math.random() * 65368) + Math.floor(Math.random() * 65368));
    for (uid in clients) {
      client = clients[uid];
      console.log((new Date()) + ' Sending message to ' + uid);
      client.emit('+', {
        'uid': userId
      });
      socket.emit('+', {
        'uid': uid
      });
    }
    clients[userId] = socket;
    console.log((new Date()) + ' Connection accepted.');
    socket.on('x', function(data) {
      var client, uid, _results;
      data.uid = userId;
      console.log((new Date()) + ' Received Message from ' + userId + ': ' + JSON.stringify(data));
      _results = [];
      for (uid in clients) {
        client = clients[uid];
        if (uid !== data.uid) {
          console.log((new Date()) + ' Sending message to ' + uid);
          _results.push(client.emit('x', data));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    });
    return socket.on('disconnect', function() {
      var client, uid, _results;
      console.log((new Date()) + " Peer " + socket + " disconnected.");
      delete clients[userId];
      _results = [];
      for (uid in clients) {
        client = clients[uid];
        console.log((new Date()) + ' Sending message to ' + uid);
        _results.push(client.emit('-', {
          'uid': userId
        }));
      }
      return _results;
    });
  });

}).call(this);
