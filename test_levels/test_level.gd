extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	$Area.transform.origin = $BlockLarge2.transform.origin + Vector3(0,1,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body.name == "AnimatedCharacter":
		body.transform.origin = Vector3()
