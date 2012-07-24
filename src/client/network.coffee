class Network
	socket: null

	onInitialization: (data) ->
		Log.log("Network::onInitialization");
		MainSingleton.get().initialize(data.seed, data.user)
	
	onAddUser: (data) ->
		Log.log("Network::onAddUser");
		MainSingleton.get().addUser()
		
	onMessage: (data) ->
		Log.log("Network::onMessage");
		MainSingleton.get().onMessage(data);
	
	onRemoveUser: (data) ->
		Log.log("Network::onRemoveUser");
		MainSingleton.get().onRemoveUser()
	
	constructor: () ->
		Log.log("Network::constructor");
		
		@socket = io.connect('http://localhost:1337');
		scope = this		
		
		@socket.on('i', (data)-> scope.onInitialization(data));
		@socket.on('+', (data)-> scope.onAddUser(data));
		@socket.on('x', (data)-> scope.onMessage(data));
		@socket.on('-', (data)-> scope.onRemoveUser(data));
		
		sendMessage = () ->
			@socket.emit('x', {z:1})
		
		$('#go').click(()->
			sendMessage()
		)

		
		
		
