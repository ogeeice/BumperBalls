extends Spatial

onready var Avatar = get_node("/root/SaveState").get_setting("PLAYER", "AVATAR")

var AvatarValue = 1
export var Tutorial = false

func _ready():
	_spearDetect()
	set_process(false)
	pass

func _process(_delta):
	_spearDetect()

func _spearDetect():
	if AvatarValue == 1:
		$"1".visible = true
		if Tutorial == true:
			$"1/AnimationPlayer".play("IDLE")
		if Tutorial == false:
			$"1/AnimationPlayer".play("MOVE")
	else:
		$"1".visible = false
		if Tutorial == true:
			$"1/AnimationPlayer".stop(true)
		if Tutorial == false:
			$"1/AnimationPlayer".stop(true)
	if AvatarValue == 2:
		$"2".visible = true
		if Tutorial == true:
			$"2/AnimationPlayer".play("IDLE")
		if Tutorial == false:
			$"2/AnimationPlayer".play("MOVE")
	else:
		$"2".visible = false
		if Tutorial == true:
			$"2/AnimationPlayer".stop(true)
		if Tutorial == false:
			$"2/AnimationPlayer".stop(true)
	if AvatarValue == 3:
		$"3".visible = true
		if Tutorial == true:
			$"3/AnimationPlayer".play("IDLE")
		if Tutorial == false:
			$"3/AnimationPlayer".play("MOVE")
	else:
		$"3".visible = false
		if Tutorial == true:
			$"3/AnimationPlayer".stop(true)
		if Tutorial == false:
			$"3/AnimationPlayer".stop(true)
	if AvatarValue == 4:
		$"4".visible = true
		if Tutorial == true:
			$"4/AnimationPlayer".play("IDLE")
		if Tutorial == false:
			$"4/AnimationPlayer".play("MOVE")
	else:
		$"4".visible = false
		if Tutorial == true:
			$"4/AnimationPlayer".stop(true)
		if Tutorial == false:
			$"4/AnimationPlayer".stop(true)
	pass

	set_process(false)
