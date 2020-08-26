extends KinematicBody

onready var animations = $Armature/AnimationPlayer
onready var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") * ProjectSettings.get_setting("physics/3d/default_gravity_vector")

export var acceleration = 0.5
export var friction = 0.1
export var max_speed = 8  # movement speed
var jump_speed = 6  # jump strength
var spin = 0.1  # rotation speed

var direction = Vector3()
var velocity = Vector3()
var jumping = false

func get_input():
	direction = Vector3()
	jumping = false
	if is_on_floor():
		if Input.is_action_pressed("move_forward"):
			animations.play("walk_blocking")
	#		velocity += transform.basis.z * speed
			direction += transform.basis.z
		if Input.is_action_pressed("move_back"):
			animations.play("walk_blocking")
	#		velocity += -transform.basis.z * speed
			direction += -transform.basis.z
		if Input.is_action_pressed("strafe_right"):
	#		velocity += -transform.basis.x * speed
			direction += -transform.basis.x
		if Input.is_action_pressed("strafe_left"):
	#		velocity += transform.basis.x * speed
			direction += transform.basis.x
	direction.normalized()

	if Input.is_action_just_pressed("jump"):
		jumping = true

func _physics_process(delta):
	get_input()
	if direction == Vector3():
		velocity.x = lerp(velocity.x, 0, friction)
		velocity.z = lerp(velocity.z, 0, friction)
	else:
		velocity = lerp(velocity, direction * max_speed, acceleration)
	velocity = move_and_slide(velocity,  Vector3.UP)
	velocity += gravity * delta
	if jumping and is_on_floor():
		animations.play("jump")
		velocity.y = jump_speed
	print("velocity " + str(velocity))

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if event.relative.x > 0:
			rotate_y(-lerp(0, spin, event.relative.x/10))
		elif event.relative.x < 0:
			rotate_y(-lerp(0, spin, event.relative.x/10))

