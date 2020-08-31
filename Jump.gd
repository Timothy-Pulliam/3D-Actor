extends Spatial

var fsm: StateMachine

const JUMP_STRENGTH = 6

func jump():
	pass
	
func enter():
	fsm.velocity.y += JUMP_STRENGTH
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
