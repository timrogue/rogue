class Log
	@lines = []
	
	@log: (s) ->
		line = (new Date()) + " " + s;
		@lines.push(line);
#		@lines = @lines.slice(0, 1000)
		
		$('#log').html(@lines.join("<BR>"));