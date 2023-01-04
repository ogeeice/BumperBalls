extends Spatial

onready var BallColor = get_node("/root/SaveState").get_setting("PLAYER", "BALL")

var BallKolor = [
	Color("#00a8f3"),
	Color("#eb1c24"),
	Color("#ff7f27"),
	Color("#4ceb1c")
	]

var BallValue = 1

onready var Ball = get_node("BalancingBall").get_surface_material(0)

func _ready():
	_spearDetect()
	pass

func _process(_delta):
	_spearDetect()

func _spearDetect():
	Ball.albedo_color = BallKolor[BallValue]

	set_process(false)
