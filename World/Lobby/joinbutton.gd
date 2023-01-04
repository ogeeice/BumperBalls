extends TouchScreenButton

signal set_connect_type

func pressed():
	if $IP_Box.text.is_valid_ip_address():
		join()
	else:
		$InvalidIP.show()

func join():
	Net.initialize_client($IP_Box.text)
	emit_signal("set_connect_type",false)


