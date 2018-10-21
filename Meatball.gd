extends Area2D

signal hit

func _on_Meatball_body_entered(body):
	if (body.get_name() == "Player"):
		emit_signal("hit")
		#print("instance driven hit")
		queue_free() #delete