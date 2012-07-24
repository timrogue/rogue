
class Renderer
	canvas: null;
	context: null;
	imageCache: {}
	
	constructor: () ->
		# wtf why doesn't this work?
#		@canvas = $('#canvas')
		@canvas = document.getElementById("canvas");
		
	render: (level) ->
#		Log.log("Renderer::render")
		floor = level.floor;
		this.prepare(level)
		
		this.renderBackground(floor.background)
		
		for rid, room of floor.rooms
			this.renderRoom(room)
			
		for pid, passage of floor.pages
			this.renderPassage(passage)
		
		for uid, user of level.users
			this.renderUser(user)	
			
	prepare: (level) ->
		@context = @canvas.getContext("2d");
		;	
	
	renderBackground: (background) ->
		@context.fillStyle = "#00A308";
		@context.beginPath();
		@context.arc(100, 100, 10, 0, Math.PI*2, true); 
		@context.closePath();
		@context.fill();
		;
		
	renderRoom: (room) ->
		@context.fillStyle = "#FF1C0A";
		@context.beginPath();
		@context.arc(70, 70, 10, 0, Math.PI*2, true); 
		@context.closePath();
		@context.fill();
		;
		
	renderPassage: (passage) ->
		@context.fillStyle = "#EF1C0A";
		@context.beginPath();
		@context.arc(50, 50, 10, 0, Math.PI*2, true); 
		@context.closePath();
		@context.fill();
		;
		
	renderUser: (user) ->
#		Log.log("Renderer::renderUser")
		image = @getImageCache(user.imageUrl)
		@context.drawImage(image, user.position[0], user.position[1], 30, 30);
		;
			
	getImageCache: (url) ->
		image = @imageCache[url];
		if (!(image?))
			image = new Image();
			image.src = url;
			@imageCache[url] = image
			
		image = @imageCache[url];
		return image;
		
			
