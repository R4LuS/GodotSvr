extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var client = null

var player_p = preload("res://Scenes/Player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	client = StreamPeerTCP.new()

func connect_to_server(host, port):
	var id = 0
	if !client.is_connected_to_host():
		print("Connecting...")
		client.connect_to_host(host, port)
		while client.get_status() == 1:
			pass
		if client.get_status() == 2:
			print("Conectado")
			var data = client.get_string(9)
			var data_split = data.split(" ")
			id = data_split[0]
			var nplayer = player_p.instance()
			get_parent().get_node("Players").add_child(nplayer)
			nplayer.set_name(data_split[0])
			nplayer.set_collision_mask_bit(10, true)
			nplayer.set_position(Vector2(int(data_split[1]), int(data_split[2])));
			nplayer.is_player = true
		return id
	else:
		print("Client already connected.")

func send(data):
	if client.is_connected_to_host():
		client.put_string(data)