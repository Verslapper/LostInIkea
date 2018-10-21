extends Node

onready var meatballPacked = preload("res://Meatball.tscn")
# Initialise list of items for sale
var portals = ["Fluegnoogit", "Hurdygurdy", "Danderbloot", "Kjellkorp", "Wamm", "Tiiktakk", "Untzuntz",
"Ferndrel", "Hoobastank", "Frassh", "Blernblern", "Numtee", "Plaknakkel", "Werlibert", "Joaskrubb"]
# Max movements before exit, something like that
var levelDepth = 3
var levels = []
var meatballs = 0
var currentLevel
var streamPlayer

func _ready(): 
	randomize()
	
	var rand = randi()%portals.size()
	for i in levelDepth*2:
		levels.append(portals[rand])
		rand = randi()%portals.size()
		
	levels.append("Exit")
	
	currentLevel = randi()%levels.size()
	nextLevel(0)
	
	streamPlayer = AudioStreamPlayer.new()
	self.add_child(streamPlayer)
	streamPlayer.stream = load("res://assets/lostinikea.wav")
	streamPlayer.play()

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
	
	var freshMeat = meatballPacked.instance()
	var randx = randi()%int(get_viewport().size.x)
	var randy = randi()%int(get_viewport().size.y)
	freshMeat.position = Vector2(randx,randy)
	
	# How do I add collision detection and hiding on generated instances?
	# I'm pretty sure this should work, but it didn't.
	#freshMeat.connect("hit", self, "_on_Meatball_hit")
	#add_child(freshMeat)
	
func win():
	var message = "You escaped! Bravo!"
	if (meatballs > 0):
		message += " And with a meaty treat too! =D"
		#message += " Meatballs: " + str(meatballs)
	$HUD/Label.set_text(message)

func _on_Portal_body_entered(body):
	if (body.name == "Player"):
		portalEntered(-1)

func _on_Portal2_body_entered(body):
	if (body.name == "Player"):
		portalEntered(1)

func _on_Meatball_hit():
	#this.hide()
	meatballs += 1
	#print(meatballs)
