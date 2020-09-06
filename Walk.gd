extends Spatial

var fsm: StateMachine

const WALK_TO_STAND_TRANSITION = 0.1
# Walking stuff
export var walk_acceleration = 0.1
export var friction = 0.7
export var max_walk_speed = 8  # movement speed

func enter():
	fsm.animations.play("walk_blocking")

func exit(next_state):
	fsm.change_to(next_state)

# Optional handler functions for game loop events
func process(delta):
	# Add handler code here
	return delta

# make this function better
func set_horizontal_direction():
	# direction = <x,0,z>
	fsm.direction = Vector3()
	if Input.is_action_pressed("move_forward"):
		fsm.direction += -fsm.transform.basis.z
	if Input.is_action_pressed("move_back"):
		fsm.direction += fsm.transform.basis.z
	if Input.is_action_pressed("strafe_right"):
		fsm.direction += fsm.transform.basis.x
	if Input.is_action_pressed("strafe_left"):
		fsm.direction += -fsm.transform.basis.x
	fsm.direction = fsm.direction.normalized()

func physics_process(delta):
	# preserve vertical velocity because of gravity (A 1)
	# "airwalk"
	var _velocity_y = fsm.velocity.y
	# Get horizontal direction to move from local basis
	set_horizontal_direction()
	# need to figure out how to rotate base mesh
	# fsm.get_node("Armature/basemesh").transform.rotated()
	# Assume an object with a direction vector equal to the zero vector
	# is not accelerating. The object can only decellerate 
	if fsm.direction == Vector3():
		# Apply friction
		fsm.velocity.x = lerp(fsm.velocity.x, 0, friction)
		fsm.velocity.z = lerp(fsm.velocity.z, 0, friction)
		if fsm.velocity.length() <= WALK_TO_STAND_TRANSITION:
			exit("Stand")
	else:
		# accelerate from walking
		fsm.animations.play("walk_blocking")
		fsm.velocity = lerp(fsm.velocity, fsm.direction * max_walk_speed, walk_acceleration)
		# maintain continuous downward velocity (A 2)
		fsm.velocity.y = _velocity_y
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
