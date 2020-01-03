extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player_p = preload("res://Scenes/Player.tscn")
var bullet_p = preload("res://Scenes/Bullet.tscn")

var id = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#id = $Network.connect_to_server("127.0.0.1", 30000)
	id = $Network.connect_to_server("godottest.apps.ocp.cluster.sergio.link", 30000)

# Called every frame. 'delta' is the elapsed time since the previous frame.
var time = 0
func _process(delta):
	time += delta
	if time >= 5:
		if $Network.client.get_status() != 2:
			print("Not connected")
		time = 0

	var bytes = $Network.client.get_available_bytes()
	if bytes > 0:
		var data = $Network.client.get_string(bytes)
		var sp = data.split("\n")
		for a in sp:
			var aux = a.split(" ")
			if aux[0] == "1001":
				update_player(aux[1], int(aux[2]), int(aux[3]), int(aux[4]), aux[5])
			elif aux[0] == "1002":
				delete_player(aux[1])
			elif aux[0] == "1011":
				create_bullet(int(aux[1]), int(aux[2]), int(aux[3]), int(aux[4]), int(aux[5]), aux[6])

func update_player(id, speedx, speedy, posx, posy):
	if not $Players.has_node(id):
		var nplayer = player_p.instance()
		$Players.add_child(nplayer)
		nplayer.set_name(id)
		nplayer.set_position(Vector2(posx, posy));
		nplayer.set_collision_mask_bit(11, true)
		print("Nuevo player creado")
	if $Players.has_node(id):
		$Players.get_node(id).set_speed(speedx, speedy)
		$Players.get_node(id).set_position(Vector2(posx, posy));

func delete_player(id):
	print("Player deleted: " + id)
	$Players.remove_child($Players.get_node(id))

func create_bullet(rotation, mousex, mousey, posx, posy, nid):
	var nbullet = bullet_p.instance()
	var mouse_pos = Vector2(mousex, mousey)
	$Bullets.add_child(nbullet)
	nbullet.set_position(Vector2(posx, posy))
	nbullet.set_collision_layer_bit(10, true)
	nbullet.pos_to = mouse_pos
	nbullet.look_at(mouse_pos)
	nbullet.id = nid
	nbullet.init()

