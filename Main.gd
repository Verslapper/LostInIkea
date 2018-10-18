extends Node

# Initialise list of items for sale
var portals = ["Fluegnoogit", "Hurdygurdy", "Danderbloot", "Kjellkorp", "Wamm", "Ferndrel"]
# Max movements before exit, something like that
var levelDepth = 2
var levels = []
var meatballs = 0
var currentLevel

func _ready(): 
	# Set up timer
	# Set up meatball counter
	
	# Initialise levels/layout
	randomize()
	
	var rand = randi()%portals.size()
	for i in levelDepth*2:
		levels.append(portals[rand])
		rand = randi()%portals.size()
		
	levels.append("Exit")
	
	currentLevel = randi()%levels.size()
	nextLevel(0)

func portalEntered(direction):
	if ((direction == -1 && $LabelLeft.get_text() == "Exit") ||
		(direction == 1 && $LabelRight.get_text() == "Exit") ):
		win()
	else:
		nextLevel(direction)

func nextLevel(direction):
	currentLevel = currentLevel + direction
	if (currentLevel + 1 == levels.size()):
		currentLevel = currentLevel - 1
		
	# Could you do a star wipe here?
	
	$LabelLeft.set_text(levels[currentLevel])
	$LabelRight.set_text(levels[currentLevel+1])
	
	var freshMeat = preload("res://Meatball.tscn").instance()
	#use this if it needs parameters
	#mySprite.init(a, b)
	var randx = randi()%int(get_viewport().size.x)
	var randy = randi()%int(get_viewport().size.y)
	freshMeat.position = Vector2(randx,randy)
	# How do I add collision detection and hiding on generated instances?
	add_child(freshMeat)
	
func win():
	var message = "You escaped! Bravo!"
	if (meatballs > 0):
		message += " Meatballs: " + str(meatballs)
	$HUD/Label.set_text(message)

func _on_Portal_body_entered(body):
	if (body.name == "Player"):
		portalEntered(-1)

func _on_Portal2_body_entered(body):
	if (body.name == "Player"):
		portalEntered(1)

func _on_Meatball_body_entered(body):
	$Meatball/CollisionShape2D.disabled = true
	$Meatball.hide()
	meatballs += 1
