class Network
	socket: null
	messageInterval: 0.25
	elapsedTime: 0

	onInitialization: (data) ->
		Log.log("Network::onInitialization");
		MainSingleton.get().initialize(data.seed, data.user)
	
	onAddUser: (data) ->
		Log.log("Network::onAddUser");
		MainSingleton.get().getLevel().addUser(new User(data))
		
	onMessage: (data) ->
		Log.log("Network::onMessage");
		MainSingleton.get().getLevel().onMessage(data);
	
	onRemoveUser: (data) ->
		Log.log("Network::onRemoveUser");
		MainSingleton.get().getLevel().onRemoveUser(data.uid)
	
	constructor: () ->
		Log.log("Network::constructor");
		
		@socket = io.connect('http://localhost:1337');
		scope = this		
		
		@socket.on('i', (data)-> scope.onInitialization(data));
		@socket.on('+', (data)-> scope.onAddUser(data));
		@socket.on('x', (data)-> scope.onMessage(data));
		@socket.on('-', (data)-> scope.onRemoveUser(data));
		
	update: (dt) ->
		@elapsedTime += dt;
		if (@elapsedTime > @messageInterval)
			@elapsedTime = 0;
			user = MainSingleton.get().getUser();
			if (user.isModified())
				user.resetModified();
				@socket.emit('x',{'t':'p', 'd':user.position});
		;
		
