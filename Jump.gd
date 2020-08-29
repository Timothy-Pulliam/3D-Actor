extends KinematicBody

var fsm: StateMachine

var jump_speed = 6  # jump strength

func enter():
	fsm.velocity.y = jump_speed
	fsm.animations.play("jump")
	yield(fsm.animations, "animation_finished")
	fsm.back()

func exit(next_state):
	fsm.change_to(next_state)

# Optional handler functions for game loop events
func process(delta):
	# Add handler code here
	return delta

func physics_process(delta):
	return delta

func input(event):
	return event

func unhandled_input(event):
	return event

func unhandled_key_input(event):
	return event

func notification(what, flag = false):
	return [what, flag]