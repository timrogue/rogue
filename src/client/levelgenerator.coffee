class LevelGenerator
	seed = null

	constructor: (seed) ->
		this.seed = seed
		
	generate: () ->
		random = new Random(seed)
		
		room1 = new Room();
		room2 = new Room();
		passage = new Passage();
		floor = new Floor();
		level = new Level();
		
		rid1 = floor.addRoom(room1);
		rid2 = floor.addRoom(room2);
		floor.addPassage(rid1, rid2, passage);
		level.setFloor(floor);
		
		return level;
		
		
		
