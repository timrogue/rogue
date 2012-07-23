(function() {
  "use strict";
  var connectToServer, content, input, socket, status, users;

  content = $('#content');

  input = $('#input');

  status = $('#status');

  users = {};

  socket = null;

  connectToServer = function() {
    var sendMessage;
    socket = io.connect('http://localhost:1337');
    socket.on('+', function(data) {
      var str;
      str = "<BR/> NEW " + JSON.stringify(data);
      return content.append(str);
    });
    socket.on('x', function(data) {
      var str;
      str = "<BR/> MSG " + JSON.stringify(data);
      return content.append(str);
    });
    socket.on('-', function(data) {
      var str;
      str = "<BR/> DEAD " + JSON.stringify(data);
      return content.append(str);
    });
    sendMessage = function() {
      return socket.emit('x', {
        z: 1
      });
    };
    return $('#go').click(function() {
      return sendMessage();
    });
  };

  connectToServer();

}).call(this);
