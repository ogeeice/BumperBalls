extends Control

export(String, FILE , ".tscn") var MainScene

onready var Db = get_node("/root/SaveState")

var AvatarName = "PLAYER"

onready var BallAsset = get_node("Spatial/Ball")
onready var CharacterAsset = get_node("Spatial/Character")

func _ready():
	AvatarName = Db.get_setting("PLAYER", "NAME")
	$BallSlider.value = Db.get_setting("PLAYER", "BALL")
	$SkinSlider.value = Db.get_setting("PLAYER", "AVATAR")
	$AvatarTag/NameHolder.placeholder_text = str(AvatarName)

func _process(_delta):
	if $AvatarTag/NameHolder.text != "":
		AvatarName = $AvatarTag/NameHolder.text
	Db.set_setting("PLAYER", "NAME", AvatarName)


func _on_Back_pressed():
	if $AvatarTag/NameHolder.text == "":
		$AvatarTag/NameHolder.text = "PLAYER"
	Db.SaveValues()
	if get_tree().change_scene(MainScene)!= OK:
		print ("An unexpected error occured when trying to switch to the Readme scene")

func _on_SkinSlider_value_changed(value):
	$Tick.play()
	CharacterAsset.AvatarValue = value
	CharacterAsset.set_process(true)
	Db.set_setting("PLAYER", "AVATAR", value)

func _on_BallSlider_value_changed(value):
	$Tick.play()
	BallAsset.BallValue = value
	BallAsset.set_process(true)
	Db.set_setting("PLAYER", "BALL", value)

func _on_SkinSlider_mouse_exited():
	self.release_focus()

func _on_BallSlider_mouse_exited():
	self.release_focus()
