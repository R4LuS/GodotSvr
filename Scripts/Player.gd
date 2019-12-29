extends KinematicBody2D

var SPEED = 300
var JUMP_SPEED = 200
var speed_y = 0
var speed_x = 0
var gravity = 150
var is_player = false
var net = null
var njumps = 2
var MAX_JUMPS = 2
var hp = 100.0

var bullet_p = preload("res://Scenes/Bullet.tscn")
var character

var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	net = get_parent().get_parent().get_node("Network")
	character = load("res://Scenes/ChRabbit.tscn").instance()
	add_child(character)

func _process(delta):
	pass


var bullet_cd = 0.4
var bullet_time = bullet_cd
var jump_cd = 0.5
var jump_time = jump_cd


var time_to_shoot = 0.2
var on_shooting = false


func _physics_process(delta):
	var nspeed_x = 0
	var nspeed_y = 0
	if is_player:
		if Input.is_action_pressed("ui_a"):
			nspeed_x = -SPEED
		if Input.is_action_pressed("ui_d"):
			nspeed_x = SPEED
		if Input.is_action_pressed("ui_s"):
			nspeed_y = JUMP_SPEED
			speed_y = nspeed_y
		if speed_y <= 5 and speed_y >= -5:
			if is_on_floor():
				njumps = 0
			if speed_x == 0:
				change_anim("hero")
			else:
				change_anim("hero_run")
		elif speed_y > 0:
			change_anim("hero_falling")
		if Input.is_action_pressed("ui_jump") and njumps < MAX_JUMPS and jump_time >= jump_cd:
			nspeed_y = -JUMP_SPEED
			speed_y = nspeed_y
			njumps += 1
			jump_time = 0
			change_anim("hero_jump")
		if Input.is_action_pressed("ui_shot") and bullet_time >= bullet_cd:
			var nbullet = bullet_p.instance()
			var mouse_pos = get_viewport().get_mouse_position()
			get_parent().get_parent().get_node("Bullets").add_child(nbullet)
			nbullet.pos_to = mouse_pos
			nbullet.set_position(position)
			nbullet.look_at(mouse_pos)
			nbullet.set_collision_layer_bit(11, true)
			nbullet.init()
			nbullet.id = get_name()
			change_anim("hero_shoot")
			on_shooting = true
			bullet_time = 0
			character.flip(false)
			if mouse_pos.x < position.x:
				character.flip(true)
			net.send("1010 " + str(nbullet.rotation) + " " + str(mouse_pos.x) + " " + str(mouse_pos.y) + " " +
			str(position.x) + " " + str(position.y) + " ")
		speed_x = nspeed_x
		if speed_x != 0:
			character.flip(speed_x < 0)
		if net:
			net.send("1000 " + str(speed_x) + " " + str(speed_y) + " " + str(position.x) + " " + str(position.y))
	bullet_time += delta
	jump_time += delta
	speed_y += gravity * delta
	get_parent().get_parent().get_node("GUI").set_ShootCd(max(0, (bullet_cd - bullet_time) / bullet_cd * 100))
	speed_y = move_and_slide(Vector2(speed_x, speed_y), Vector2.UP).y

func change_anim(hero_name):
	if on_shooting != true:
		character.change_anim(hero_name)
	elif time_to_shoot < bullet_time:
			on_shooting = false

func set_speed(nx, ny):
	speed_x = int(nx)
	speed_y = int(ny)

func hp_down(dmg):
	hp = max(hp - dmg, 0)
	$HpBar.scale = Vector2(hp/100.0, 1)
