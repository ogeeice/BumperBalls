extends TouchScreenButton

signal set_connect_type

func _ready():
# WINDOWS ADDRESS
#	$IP.text = "IP: " + str(IP.get_local_addresses()[7])

# ANDROID IP ADDRESS
	$IP.text = "IP: " + str(IP.get_local_addresses()[3])


func host():
	Net.initialize_server()
	emit_signal("set_connect_type", true)
