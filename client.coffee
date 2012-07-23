# i have no idea what this means - tjp
"use strict";

# for better performance - to avoid searching in DOM
content = $('#content');
input = $('#input');
status = $('#status');

users = {}
socket = null

connectToServer = () ->
	socket = io.connect('http://localhost:1337');
		
	socket.on('+', (data)->
		str = "<BR/> NEW " + JSON.stringify(data);
		content.append(str);
	);
	
	socket.on('x', (data)->
		str = "<BR/> MSG " + JSON.stringify(data);
		content.append(str);
	);
	
	socket.on('-', (data)->
		str = "<BR/> DEAD " + JSON.stringify(data);
		content.append(str);
	);
	
	sendMessage = () ->
		socket.emit('x', {z:1})
	
	$('#go').click(()->
		sendMessage()
	)
	
connectToServer();