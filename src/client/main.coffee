
class Main
	user: null;
	renderer: null;
	level: null;
	network: null;
		
	constructor: () ->
		Log.log("Main::construct");
		
	start: () ->		
		Log.log("Main::start")
		@renderer = new Renderer();
		@network = new Network();
		
	initializeTimers: () ->
		# hmmmmmmm
		scope = this
		window.setInterval(
			() -> scope.draw(), 
			100
		);
	
	initialize: (seed, user) ->
		levelGenerator = new LevelGenerator(seed);
		@level = levelGenerator.generate();
		@user = user;
		this.initializeTimers()
		Log.log("initializeend")
		
	draw: () ->
		@renderer.render(@level)
	
	getCurrentLevel: () ->
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






