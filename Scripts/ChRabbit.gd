extends Node2D

var anim_hero = Sprite
var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_hero = $hero
	timer.connect("timeout", self, "animation")
	add_child(timer)
	timer.start(0.1)

func change_anim(name_anim):
	anim_hero.set_visible(false)
	anim_hero = get_node(name_anim)
	anim_hero.set_visible(true)

func animation():
	anim_hero.set_frame((anim_hero.get_frame() + 1) % anim_hero.get_hframes())
	
func flip(fliph):
	anim_hero.set_flip_h(fliph)