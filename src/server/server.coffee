# http://ejohn.org/blog/ecmascript-5-strict-mode-json-and-more/
# i have no idea what this means - tjp
"use strict";

# Optional. You will see this name in eg. 'ps' or 'top' command
process.title = 'rogue';

# list of currently connected clients
clients = { };

handler = (req, res) ->
#	console.log(req.url)
	fs.readFile(__dirname + req.url, (err, data)->
		if (err)
			res.writeHead(500);
			return res.end(__dirname + req.url);

		res.writeHead(200);
		res.end(data);
	)

app = require('http').createServer(handler)
io = require('socket.io').listen(app);
fs = require('fs');
app.listen(1337)

seed = Math.random() * 10;

########################
class User	
	uid: "-1" 
	name: "Anonymous"
	image: ""
	position: [0,0];
		

class Client
	user: null;
	socket: null;
	
	constructor: (user, socket) ->
		this.user = user;
		this.socket = socket;
#############################

# on connection
io.sockets.on('connection', (socket)->
	console.log((new Date()) + ' Connection from origin.');
	
	user = new User()
	
	user.uid = 
		"" + (Math.floor(Math.random() * 65368) + 
		Math.floor(Math.random() * 65368) + 
		Math.floor(Math.random() * 65368));
		
	socket.emit('i', {user:user, seed:seed});

	# reflect to clients a new user, and the existing to the new user
	for uid, client of clients
		console.log((new Date()) + ' Sending message to '+ uid);
		client.emit('+', { 'uid': user.id });
		socket.emit('+', { 'uid': uid })
		
	# register the client
	
	clients[user.id] = User(user, socket);
	
	# log it
	console.log((new Date()) + ' Connection accepted.');
	
	# user sent some message
	socket.on('x', (data) ->
		# mark the uid of the message
		data.uid = user.id;
	
		# todo:
		#   code for entry
		#   updating server state
		#   code for exit
	
		# log and broadcast the message
		console.log((new Date()) + ' Received Message from ' + user.id + ': ' + JSON.stringify(data));

		# reflect it
		for uid, client of clients
			# wtf, maybe javascript keys can only be strings? 
			if (uid != data.uid)
				console.log((new Date()) + ' Sending message to '+ uid);
				client.socket.emit('x', data)
	);

	# on disconnect
	socket.on('disconnect', () ->
		console.log((new Date()) + " Peer " + socket + " disconnected.");
		# remove user from the list of connected clients
		delete clients[user.id];

		# reflect the death
		for uid, client of clients
			console.log((new Date()) + ' Sending message to '+ uid);
			client.socket.emit('-', { 'uid': user.id });

	);
);
