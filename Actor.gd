extends StateMachine

onready var animations = $Armature/AnimationPlayer

# enable accelerations?
const ACCEL_ON = true
# Set gravity, velocity, and initial position
onready var acceleration = ProjectSettings.get_setting("physics/3d/default_gravity") * ProjectSettings.get_setting("physics/3d/default_gravity_vector")
onready var velocity = Vector3()
# This velocity vector with unit length
onready var direction = Vector3()
# initial position (local basis)
onready var _initial_position = Vector3(0,0,0)

# mouse controls
onready var rotation_speed = 0.1  # rotation speed


func _ready():
	# set initial position
	transform.origin = _initial_position
	# Basis includes orientation and scale (i.e. <0.3, 0.3, 0.3>)
	# Default basis sets scale = 1
	# transform.basis = Basis()
	
	
# Also calls current states _physics_process
func _physics_process(delta):
	# Always apply gravity
	if ACCEL_ON:
		velocity.y += acceleration.y * delta
	velocity = move_and_slide(velocity, Vector3.UP)


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if event.relative.x > 0:
			rotate_y(-lerp(0, rotation_speed, event.relative.x/10))
		elif event.relative.x < 0:
			rotate_y(-lerp(0, rotation_speed, event.relative.x/10))
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_R:
			get_tree().reload_current_scene()
