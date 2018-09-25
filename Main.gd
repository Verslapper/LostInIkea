extends Node

# Initialise list of items for sale
var portals = ["Fluegnoogit", "Hurdygurdy", "Danderblut", "Kjellkorp", "Wamm"]
# Max movements before exit, something like that
var levelDepth = 2
var levels = []

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	# Set up physics shit
	
	# Set up timer
	
	# Initialise levels/layout
	randomize()
	
	var rand = randi()%portals.size()
	for i in levelDepth*2:
		levels.append(portals[rand])
		rand = randi()%portals.size()
		
	levels.append("Exit")
	
	# pick a level
	rand = randi()%levels.size()
	var currentLevel = levels[rand]
	# if currentLevel is exit yay!
	
	rand = randi()%levels.size()
	$LabelLeft.set_text(levels[rand])
	
	rand = randi()%levels.size()
	$LabelRight.set_text(levels[rand])
	
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
