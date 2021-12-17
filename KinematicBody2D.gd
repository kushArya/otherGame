extends KinematicBody2D

#player shmovement
export var max_speed = 150
export var grav = 10
const ACC = 50
export var jump = -400
export var wall_slide_speed = 200
export var wall_slide_acc = 8
const UP = Vector2(0,-1)
var motion = Vector2()

#gun fire 
const projScene = preload("ProjTest.tscn")
var aimDir = Vector2()


#gun dash 
var been_shot = false
var dash_power = 500
var shootFrames = 60
var count = shootFrames

#shield
var shield_up = false

func _physics_process(_delta):
	if is_on_wall() and (Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left")):
		motion.y = min(motion.y + wall_slide_acc, wall_slide_speed)
	else:
		motion.y += grav
		
	var friction = false 
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACC,max_speed)
		$Sprite.flip_h=false
		$GunAim/Sprite.flip_h = false
		$Sprite.play("run")

	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACC, -max_speed)
		$Sprite.flip_h=true
		$GunAim/Sprite.flip_h = true
		$Sprite.play("run")
	else:
		friction = true
		$Sprite.play("idle")
		
	if is_on_floor() or is_on_wall():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = jump
		
		if friction == true: 
			motion.x = lerp(motion.x, 0, 0.2)
	
	else:
		if motion.y<0:
			$Sprite.play("jump")
		else: 
			$Sprite.play("fall")
			if friction == true: 
				motion.x = lerp(motion.x, 0, 0.05)
	
	if Input.is_action_just_pressed("ui_accept"):
		count = 0
		$GunAim.shoot(aimDir)

	if Input.is_action_pressed("ui_select"):
		shield_up = true
	else:
		shield_up = false
	
	motion = move_and_slide(motion, UP) 
	set_aim()
	pass

func set_aim():
	aimDir = (position - get_global_mouse_position()).normalized()
	$GunAim.look_at(get_global_mouse_position())
	$GunAim.equip_shield(shield_up)
	$hitbox.set_monitoring(not shield_up)	#disables player hitbox when shield is up
	var dash_dir = $GunAim.check_shield_coll()
	if dash_dir:
		
		pass #use later to make the dash stuff happens. 

