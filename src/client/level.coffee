class Room
	topLeft: [0,0]
	bottomRight: [0,0]
	
class Passage
	nothing: null

class Floor
	rid: 0
	background: null
	dimensions: [0,0]
	
	rooms: {}
	passages: {}	
	
	addRoom: (room) ->
		room.id = ++@rid;
		this.rooms[room.id] = room;
		return room.id
		
	addPassage: (rid1, rid2, passage) ->
		id = rid1+"|"+rid2
		this.passages[id] = passage;
		return id
	
class Level
	users: null
	floor: null
	
	constructor: () ->
		@users = {}
		@floor = null
	
	setFloor: (floor) ->
		@floor = floor;
		
	addUser: (user) ->
		@users[user.uid] = user;
		
	getUser: (uid) ->
		user = @users[uid]
		return user;
		
	onMessage: (data) ->
		@getUser(data.uid).applyMessage(data)
		
	removeUser: (user) ->
		delete users[user.uid];
		

		
		
