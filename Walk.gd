extends KinematicBody

var fsm: StateMachine

export var acceleration = 0.5
export var friction = 0.1
export var max_speed = 8  # movement speed

func enter():
	fsm.animations.play("walk_blocking")

func exit(next_state):
	fsm.change_to(next_state)

func get_input():
	fsm.direction = Vector3()
	if Input.is_action_pressed("move_forward"):
		fsm.animations.play("walk_blocking")
		fsm.direction += transform.basis.z
	if Input.is_action_pressed("move_back"):
		fsm.animations.play("walk_blocking")
		fsm.direction += -transform.basis.z
	if Input.is_action_pressed("strafe_right"):
		fsm.direction += -transform.basis.x
	if Input.is_action_pressed("strafe_left"):
		fsm.direction += transform.basis.x
	fsm.direction = fsm.direction.normalized()

# Optional handler functions for game loop events
func process(delta):
	# Add handler code here
	return delta

func physics_process(delta):
	get_input()
	#fsm.animations.play("walk_blocking")
	if fsm.direction == Vector3():
		fsm.velocity.x = lerp(fsm.velocity.x, 0, friction)
		fsm.velocity.z = lerp(fsm.velocity.z, 0, friction)
	else:
		fsm.velocity = lerp(fsm.velocity, fsm.direction * max_speed, acceleration)
	if fsm.velocity.length() <= 0.01:
		exit("Stand")
	return delta

func input(event):
	return event

func unhandled_input(event):
	if Input.is_action_just_pressed("jump"):
		exit("Jump")

func unhandled_key_input(event):
	return event

func notification(what, flag = false):
	return [what, flag]
