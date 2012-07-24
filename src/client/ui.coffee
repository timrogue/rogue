
class UI
	dx: 0
	dy: 0
	
	constructor: () ->
		@dx = 0
		@dy = 0
		scope = this
		$(document).keydown((event)->scope.processKeyDown(event));
		$(document).keyup((event)->scope.processKeyUp(event));
				
	processKeyDown:(event) ->
#		Log.log("UI::processKeyDown")
		direction = null;
		
		if (event.keyCode == 37) 
			@dx = -100
			
		if (event.keyCode == 38) 
			@dy = -100
			
		if (event.keyCode == 39) 
			@dx = 100
			
		if (event.keyCode == 40) 
			@dy = 100
		
		if (@dx != 0 || @dy != 0)
			event.preventDefault();
		
		MainSingleton.get().getUser().setVelocity([@dx, @dy])

	processKeyUp:(event) ->
#		Log.log("UI::processKeyUp")
		
		if (event.keyCode == 37 && @dx == -100) 
			@dx = 0
			
		if (event.keyCode == 38 && @dy == -100) 
			@dy = 0
			
		if (event.keyCode == 39 && @dx == 100) 
			@dx = 0
			
		if (event.keyCode == 40 && @dy == 100) 
			@dy = 0
		
		MainSingleton.get().getUser().setVelocity([@dx, @dy])

