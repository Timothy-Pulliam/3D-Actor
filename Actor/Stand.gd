extends Spatial

var fsm: StateMachine

func enter():
	pass

func exit(next_state):
	fsm.change_to(next_state)

# Optional handler functions for game loop events
func process(delta):
	# Add handler code here
	return delta

func physics_process(delta):
	# this is super inefficient. There has to be a better way to keep
	# move and slide from slowly increasing horizontal velocity
	if fsm.is_on_floor():
		fsm.velocity = Vector3()
	return delta

func input(event):
	if fsm.is_on_floor():
		if Input.is_action_just_pressed("jump"):
			exit("Jump")
		if Input.is_action_pressed("move_forward"):
			exit("Walk")
		if Input.is_action_pressed("move_back"):
			exit("Walk")
		if Input.is_action_pressed("strafe_right"):
			exit("Walk")
		if Input.is_action_pressed("strafe_left"):
			exit("Walk")
	return event


func unhandled_input(event):
	return event

func unhandled_key_input(event):
	return event

func notification(what, flag = false):
	return [what, flag]
