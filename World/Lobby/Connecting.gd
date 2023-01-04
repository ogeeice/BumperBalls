extends ColorRect

const CONNECT_TEXT = ["WAITING FOR PLAYERS...","CONNECTING TO SERVER..."]

func set_connect_type(host):
	show()
	if host:
		$Label.text = CONNECT_TEXT[0]
	else:
		$Label.text = CONNECT_TEXT[1]
