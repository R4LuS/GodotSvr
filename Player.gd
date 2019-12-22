extends KinematicBody2D

var SPEED = 50
var JUMP_SPEED = 160
var speed_y = 0
var speed_x = 0
var gravity = 98
var is_player = false
var net = null


var bullet_p = preload("res://Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	net = get_parent().get_parent().get_node("Network")
	pass # Replace with function body.


func _process(delta):
	pass
		

var bullet_cd = 0.5
var bullet_time = bullet_cd

func _physics_process(delta):
	var nspeed_x = 0
	var nspeed_y = 0
	if is_player:
		if Input.is_action_pressed("ui_jump") and is_on_floor():
			nspeed_y = -JUMP_SPEED
			speed_y = nspeed_y
		if Input.is_action_pressed("ui_a"):
			nspeed_x = -SPEED
		if Input.is_action_pressed("ui_d"):
			nspeed_x = SPEED
		if Input.is_action_pressed("ui_shot") and bullet_time >= bullet_cd:
			var nbullet = bullet_p.instance()
			var mouse_pos = get_viewport().get_mouse_position()
			get_parent().get_parent().get_node("Bullets").add_child(nbullet)
			nbullet.pos_to = mouse_pos
			nbullet.set_position(position)
			nbullet.look_at(mouse_pos)
			nbullet.init()
			bullet_time = 0
			net.send("1010 " + str(nbullet.rotation) + " " + str(mouse_pos.x) + " " + str(mouse_pos.y) + " " +
			str(position.x) + " " + str(position.y) + " ")
		speed_x = nspeed_x
		if net:
			net.send("1000 " + str(speed_x) + " " + str(speed_y) + " " + str(position.x) + " " + str(position.y))
	bullet_time += delta
	speed_y += gravity * delta
	move_and_slide(Vector2(speed_x, speed_y), Vector2.UP)

func set_speed(nx, ny):
	speed_x = int(nx)
	speed_y = int(ny)
	
