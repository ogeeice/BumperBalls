extends Control

export(String, FILE , ".tscn") var MultiplayerScene
export(String, FILE , ".tscn") var AvatarMenu

onready var NameBox = $NameBox/Name

func _process(_delta):
	NameBox.text = str(get_node("/root/SaveState").get_setting("PLAYER", "NAME"))

func _on_Multiplayer_pressed():
	if get_tree().change_scene(MultiplayerScene)!= OK:
		print ("An unexpected error occured when trying to switch to the Readme scene")

func _on_Avatar_pressed():
	if get_tree().change_scene(AvatarMenu)!= OK:
		print ("An unexpected error occured when trying to switch to the Readme scene")

func _on_Exit_pressed():
	get_tree().quit()
