extends Spatial

var fsm: StateMachine

const ABOUT_ZERO = 0.001
# Walking stuff
export var walk_acceleration = 0.1
export var friction = 0.7
export var max_walk_speed = 8  # movement speed


func enter():
	fsm.animations.play("walk_blocking")


func exit(next_state):
	fsm.change_to(next_state)


func process(delta):
	return delta


# Linear Algebra functions
func projection_of_u_on_v(u, v):
	var e = (v.dot(u) / v.dot(v)) * v
	return e.normalized()


func get_input():
	# direction = <x,0,z>
	fsm.direction = Vector3()
	# Walk towards or away from camera
	if Input.is_action_pressed("move_forward"):
		fsm.direction += -fsm.camera.global_transform.basis.z
	if Input.is_action_pressed("move_back"):
		fsm.direction += fsm.camera.global_transform.basis.z
	if Input.is_action_pressed("strafe_right"):
		fsm.direction += fsm.camera.global_transform.basis.x
	if Input.is_action_pressed("strafe_left"):
		fsm.direction += -fsm.camera.global_transform.basis.x
	fsm.direction = fsm.direction.normalized()


func physics_process(delta):
	# preserve vertical velocity because of gravity (A 1)
	# "airwalk"
	var _velocity_y = fsm.velocity.y
	# Get horizontal direction to move from local basis
	get_input()
	# Assume an object with a direction vector equal to the zero vector
	# is not accelerating. The object can only deccelerate
	if fsm.direction == Vector3():
		# Apply friction (no user input)
		fsm.velocity.x = lerp(fsm.velocity.x, 0, friction)
		fsm.velocity.z = lerp(fsm.velocity.z, 0, friction)
		# transition back into stand state if basically standing still
		if fsm.velocity.length() <= ABOUT_ZERO:
			fsm.velocity.z = 0
			fsm.velocity.x = 0
			exit("Stand")
	else:
		# player is walking
		fsm.animations.play("walk_blocking")
		fsm.velocity.z = lerp(fsm.velocity.z, fsm.direction.z * max_walk_speed, walk_acceleration)
		fsm.velocity.x = lerp(fsm.velocity.x, fsm.direction.x * max_walk_speed, walk_acceleration)
		# preserve vertical velocity because of gravity (A 2)
		fsm.velocity.y = _velocity_y

		# Change mesh direction to face direction vector
		#fsm.get_node("Armature/basemesh").look_at(-Vector3(fsm.direction.x, 0, fsm.direction.z), Vector3.UP)
		# construct a basis using graham schmidt
		var k = fsm.direction
#		#var j = Vector3.UP - projection_of_u_on_v(Vector3.UP, k)
		var j = Vector3.UP
		var i = j.cross(k)
		fsm.get_node("Armature/basemesh").global_transform.basis = Basis(i, j, k).orthonormalized().scaled(
			Vector3(0.1, 0.1, 0.1)
		)

		# Other ways to direct player movement
		#fsm.get_node("Armature/basemesh").look_at(fsm.direction, Vector3.UP)
		# fsm.get_node("Armature/basemesh").transform.rotated()
	return delta


func input(event):
	return event


func unhandled_input(event):
	if Input.is_action_just_pressed("jump") and fsm.is_on_floor():
		exit("Jump")


func unhandled_key_input(event):
	return event


func notification(what, flag = false):
	return [what, flag]
