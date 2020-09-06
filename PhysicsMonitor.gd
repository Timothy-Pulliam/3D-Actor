extends Panel


var node = get_parent()

func _physics_process(delta):
	print("hello?")
	$VBoxContainer/Label.text = "acceleration " + str(get_parent().acceleration)
	$VBoxContainer/Label2.text = "velocity " + str(get_parent().velocity)
	$VBoxContainer/Label3.text = "origin " + str(get_parent().transform.origin)
	$VBoxContainer/Label4.text = "basis " + str(get_parent().transform.basis)
	$VBoxContainer/Label5.text = "direction " + str(get_parent().direction)
	$VBoxContainer/Label6.text = "jump_velocity " + str(get_parent().get_node("Jump").jump_velocity)
	$VBoxContainer/Label6.text = "max_walk_speed " + str(get_parent().get_node("Walk").max_walk_speed)
	$VBoxContainer/Label7.text = "walk_acceleration " + str(get_parent().get_node("Walk").walk_acceleration)
	$VBoxContainer/Label8.text = "friction " + str(get_parent().get_node("Walk").friction)
	
