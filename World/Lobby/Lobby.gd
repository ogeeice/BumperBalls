extends Control

export(String, FILE , ".tscn") var MainMenu

func _ready():
	if get_tree().connect("connected_to_server", self ,"connected")!= OK:
		print ("An unexpected error occured when trying to switch to the Readme scene")


func connected():
	if not Net.is_host:
		rpc("begin_game")
		begin_game()

remote func begin_game():
	$BeginTimer.start()


func _on_Back_pressed():
	if get_tree().change_scene(MainMenu)!= OK:
		print ("An unexpected error occured when trying to switch to the Readme scene")


func _on_BeginTimer_timeout():
	if get_tree().change_scene("res://World/Level/1/Level1.tscn")!= OK:
		print ("An unexpected error occured when trying to switch to the Readme scene")
