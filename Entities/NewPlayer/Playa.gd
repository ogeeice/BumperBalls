extends KinematicBody

var speed = 5
var gravity = -100
var ANGULAR_ACCELERATION = 10
var Push_Force = 2.25

var direction = Vector3()
var is_master = false

var player

onready var Joystick_Control = get_node("UI/Hold/Pos/Joystick")
onready var Hit = $Detectorate

onready var Collider1 = $CollisionShape
onready var Collider2 = $Detectorate/CollisionShape


onready var CharName = get_node("/root/SaveState").get_setting("PLAYER", "NAME")
onready var Costume = get_node("/root/SaveState").get_setting("PLAYER", "AVATAR")
onready var BallType = get_node("/root/SaveState").get_setting("PLAYER", "BALL")
onready var beachball = get_node("Ball")

func initialize(id):
	name = str(id)
	if id == Net.net_id:
		is_master = true
		$NameTag/DisplayName/ID_label.text = str(CharName)
		$MeshHolder/Character.AvatarValue = Costume
		$MeshHolder/Character._spearDetect()
		beachball.BallValue = BallType
		beachball._spearDetect()


func _physics_process(delta):
	if is_master:
		if  direction:
			beachball.rotation = direction * 1.5
			$MeshHolder.rotation.y = lerp_angle($MeshHolder.rotation.y, atan2( direction.x, direction.z),delta * ANGULAR_ACCELERATION)
		direction = Joystick_Control.get_velo()
		direction = direction.normalized()
		direction.y += gravity * delta
		move_and_slide(direction * speed, Vector3.UP)
		
		rpc_unreliable("update_position", global_transform.origin, $MeshHolder.rotation.y,$Ball.rotation)
		rpc_unreliable("_on_Detectorate_area_entered", Hit)
		rpc_unreliable("transfer_data",CharName,Costume,BallType)

remote func update_position(pos,rot,brot):
	global_transform.origin = pos
	$MeshHolder.rotation.y = rot
	beachball.rotation = brot


remote func transfer_data(Name,Avatar,ball):
	$NameTag/DisplayName/ID_label.text = str(Name)
	$MeshHolder/Character.AvatarValue = Avatar
	$MeshHolder/Character._spearDetect()
	beachball.BallValue = ball
	beachball._spearDetect()

func _on_Detectorate_area_entered(area):
	if area.is_in_group("Detect"):
		$Bump.play()
		global_transform.origin -= Vector3(direction.x,0,direction.z) * Push_Force
	
	if area.is_in_group("Death"):
		$Death.play()
		$Death/Timer.start()

func _on_Timer_timeout():
	self.queue_free()
