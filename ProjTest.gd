extends RigidBody2D

var collided_with_shield = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_bounce(1)
	set_friction(0)
	set_process(true)
	pass # Replace with function body.




func _on_ProjTest_body_entered(body):
	if body.name == "Shield":
		collided_with_shield = true 
