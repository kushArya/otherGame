extends Area2D


export var projectile_speed = -1000

const projScene = preload("ProjTest.tscn")
const gun_offset = 40 #change later to the sprite length


var proj_list = []

func shoot(aimDir):
	var proj_pos = -gun_offset*aimDir + position
	var proj = projScene.instance()
	proj_list.append(proj)
	if len(proj_list)>4:
		proj_list[0].queue_free()
		proj_list.remove(0)
	get_parent().add_child(proj)

	proj.set_position(proj_pos)
	proj.apply_central_impulse(projectile_speed * aimDir)

func equip_shield(equip):
	$Shield.set_visible(equip)
	$Shield/CollisionShape2D.set_disabled(not equip)
	
func check_shield_coll():
	for i in range(len(proj_list)):
		if proj_list[i].collided_with_shield:
			var p_motion = proj_list[i].linear_velocity
			proj_list[i].queue_free()
			proj_list.remove(i)
			return p_motion
	return false
