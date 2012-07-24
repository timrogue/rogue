class User	
	uid: "-1" 
	name: ""
	imageUrl: ""
	position: [0,0];
	velocity: [0,0]

	constructor: (data) ->
		@uid = data.uid;
		@name = data.name;
		@imageUrl = data.imageUrl;
		@position = data.position;
		@motion = [0,0]
		@modified = false	
		
	isModified: () ->
		return @modified
		
	setVelocity: (v) ->
		@velocity = v
		
	resetModified: () ->
		@modified = false
	
	update: (dt) ->
		if (@velocity[0] !=0 || @velocity[1] != 0)
			@position[0] += @velocity[0] * dt
			@position[1] += @velocity[1] * dt
			@modified = true;
			
	applyMessage: (data) ->
		if (data.t == 'p')
			@position = data.d;
			
	