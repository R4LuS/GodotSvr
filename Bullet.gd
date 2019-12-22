extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var SPEED = 300
var time = 0

var pos_to = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "mcollision")

func _physics_process(delta):
	time += delta
	if time > 2:
		get_parent().remove_child(self)

func mcollision(node):
	get_parent().remove_child(self)

func init():
	var speedv = (pos_to - position).normalized() * SPEED
	set_linear_velocity(speedv)