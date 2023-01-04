extends Area2D

onready var Outer = get_node("Outer")
onready var Inner = get_node("Outer/Inner")

onready var Max_distance = get_node("TouchSensor").shape.radius

var touched = false

func _input(event):
	if event is InputEventScreenTouch:
		var distance = event.position.distance_to(Outer.global_position)
		if not touched:
			if distance < Max_distance:
				touched = true
		else:
			Inner.position = Vector2(0,0)
			touched = false

func _process(_delta):
	if touched == true:
		Inner.global_position = get_global_mouse_position()
		Inner.position = Outer.position + (Inner.position - Outer.position).clamped(Max_distance)

func get_velo():
	var Joy_Velo = Vector3(0,0,0)
	Joy_Velo.x =  Inner.position.x / Max_distance
	Joy_Velo.z =  Inner.position.y / Max_distance
	return Joy_Velo
