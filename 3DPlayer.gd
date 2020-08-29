extends StateMachine

onready var animations = $Armature/AnimationPlayer
onready var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") * ProjectSettings.get_setting("physics/3d/default_gravity_vector")
#
#export var acceleration = 0.5
#export var friction = 0.1
#export var max_speed = 8  # movement speed
var spin = 0.1  # rotation speed

var direction = Vector3()
var velocity = Vector3()


func _physics_process(delta):
	# Always apply gravity
	velocity += gravity * delta
	velocity = move_and_slide(velocity, Vector3.UP)
	print("position " + str(translation))
	print("velocity " + str(velocity))
	print("direction " + str(direction))
	print("rotation " + str(get_rotation()))
	print("transform " + str(get_transform()))
	

func _unhandled_input(event):
#	if event is InputEventMouseMotion:
#		if event.relative.x > 0:
#			rotate_y(-lerp(0, spin, event.relative.x/10))
#		elif event.relative.x < 0:
#			rotate_y(-lerp(0, spin, event.relative.x/10))
	if event is InputEventMouseMotion:
		if event.relative.x > 0:
			rotate_object_local(transform.basis.y.normalized(), -lerp(0, spin, event.relative.x/10))
		elif event.relative.x < 0:
			rotate_object_local(-transform.basis.y.normalized(), lerp(0, spin, event.relative.x/10))
