extends Spatial

export var Time = 60
export(String, FILE , ".tscn") var LobbyMenu

onready var PLAYER = preload("res://Entities/NewPlayer/Playa.tscn")
onready var spawn_points = $SpoinPointHolder.get_children()

export var Outers_Num = 4

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()

func _ready():
	$Menu/BootUp.visible = true
	randomize()
	print("SPAWN POINTS: ", spawn_points[1].translation)
	Net.set_ids()
	create_players()
	get_tree().paused = true

func _process(delta):
	Time = clamp(Time,0,60)
	Outers_Num = clamp(Outers_Num,1,4)
	$Menu/Score/TimerStuff.text = str(Time)
	if Time == 0:
		$MatchEnd.start()
	
	if Outers_Num == 1:
		$ScoreTimer.stop()

func create_players():
	for id in Net.peer_ids:
		create_player(id)
	create_player(Net.net_id)


func create_player(id):
	var p = PLAYER.instance()
	add_child(p)
	get_parent().add_child(p)
	p.global_transform = spawn_points[randi() % spawn_points.size()].global_transform
	p.scale = Vector3.ONE
	p.initialize(id)


remote func _on_Death_body_entered(body):
	if body.is_in_group("PLAYER"):
		if body.is_master == true:
			$Menu/Blank.visible = true
	
		if Outers_Num == 4:
			get_node("Menu/Control/Fourth/Name").text = str(body.CharName)
			get_node("Menu/Control/Fourth").visible = true
			if body.is_master == true:
				$Menu/Blank/Fail.visible = true
			pass
		elif Outers_Num == 3:
			get_node("Menu/Control/Third/Name").text = str(body.CharName)
			get_node("Menu/Control/Third").visible = true
			if body.is_master == true:
				$Menu/Blank/Fail.visible = true
			pass
		elif Outers_Num == 2:
			get_node("Menu/Control/Second/Name").text = str(body.CharName)
			get_node("Menu/Control/Second").visible = true
			if body.is_master == true:
				$Menu/Blank/Fail.visible = true
			pass
		else:
			get_node("Menu/Control/First/Name").text = str(body.CharName)
			get_node("Menu/Control/First").visible = true
			$Menu/Blank/Fail.visible = false
			pass
		Outers_Num -= 1

func _on_Menu_pressed():
	get_tree().change_scene(LobbyMenu)


func _on_Exit_pressed():
	get_tree().quit()


func _on_StartUp_timeout():
	$Menu/BootUp.visible = false
	get_tree().paused = false
	$ScoreTimer.start()


func _on_TextShow_timeout():
	$Menu/BootUp/Start.visible = true


func _on_ScoreTimer_timeout():
	Time -= 1


func _on_MatchEnd_timeout():
	$Menu/MatchEndScreen.visible = true
	$TextShows.start()


func _on_TextShows_timeout():
	$Menu/Blank.visible = true
	$Menu/Blank/Victory.visible = true


remote func _on_Detectorate_body_exited(body):
	if body.is_in_group("PLAYER"):
		if Outers_Num == 2:
			var Player = $Landscape/Detectorate.get_overlapping_bodies()
			if Player[0].is_master == true:
				$MatchEnd.start()
		$ScoreTimer.stop()
