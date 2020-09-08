extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# add gravitational pull towards another object
func add_gravity(object):
	# direction gravity will influence object
	var direction = transform.origin - object.transform.origin
	object.velocity += 7 * direction.normalized() / direction.dot(direction)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	add_gravity($"../AnimatedCharacter")
