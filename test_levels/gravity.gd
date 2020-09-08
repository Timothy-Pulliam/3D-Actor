extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func add_gravity(body):
	var distance = global_transform.origin - body.global_transform.origin
	body.acceleration = 3 * distance.normalized() / distance.dot(distance)
	body.transform.basis.z = distance.normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	add_gravity($"../Actor")
