
class Main
	user: null;
	renderer: null;
	level: null;
	network: null;
	ui: null;
		
	constructor: () ->
		Log.log("Main::construct");
		
	start: () ->		
		Log.log("Main::start")
		@renderer = new Renderer();
		@network = new Network();
		@ui = new UI();
		
	initializeTimers: () ->
		# hmmmmmmm
		scope = this
		window.setInterval(
			() -> scope.update(0.1), 
			100
		);
	
	initialize: (seed, user) ->
		Log.log("Main::initialize")
		levelGenerator = new LevelGenerator(seed);
		@level = levelGenerator.generate();
		@user = new User(user);
		@level.users[user.uid] = @user
		this.initializeTimers()
		
	update: (dt) ->
		@user.update(dt);
		@network.update(dt)
		@renderer.render(@level)
	
	getLevel: () ->
		return @level;
		
	getRenderer: () ->
		return @renderer
		
	getUser: () ->
		return @user;
		
		
class MainSingleton
	main = null
	
	@set: (m) ->
		main = m;
	
	@get: () -> main;
		
		
$('#main').click(() ->
	Log.log("starting ...");
	MainSingleton.set(new Main());
	main = MainSingleton.get();
	main.start();
	Log.log("started");
)






