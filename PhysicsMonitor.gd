extends Panel

# attributes of the parent or specified children of the parent
var attributes = ["acceleration", "velocity", "direction", "rotation_speed", 
	"transform.basis", "transform.origin",
	"Jump/jump_velocity", "Walk/walk_acceleration", "Walk/friction", "Walk/max_walk_speed",]

# maps the attributes to their respective lables
var attr2label_dict = {}

var rsplit = funcref(self, "_rsplit")
func _rsplit(text: String, delimiter:="/"):
	return text.split(delimiter)[-1]
	

func map(input: Array, function: FuncRef) -> Array:
	var result := []
	result.resize(input.size())
	for i in range(input.size()):
		result[i] = function.call_func(input[i])
	return result

func _ready():
	for attribute in attributes:
		var label = Label.new()
		label.size_flags_horizontal = SIZE_EXPAND_FILL
		attr2label_dict[attribute] = label
		$VBoxContainer.add_child(attr2label_dict[attribute], true)
		attr2label_dict[attribute].text = attribute

		
		
func _physics_process(delta):
	# set label text
	for attribute in attributes:
		#attr2label_dict[attribute].text = "yolo"
		if attribute.count("/") == 0:
			if attribute.count(".") > 0:
				attr2label_dict[attribute].text = attribute + ": " + str(get_parent().get(attribute.split(".")[0])[attribute.split(".")[1]])
			else:
				attr2label_dict[attribute].text = attribute + ": " + str(get_parent().get(attribute))
		else:
			var i = attribute.find_last("/")
			var attribute_node = attribute.substr(0, i)
			var _attribute = attribute.substr(i+1)
			attr2label_dict[attribute].text = attribute + ": " + str(get_parent().get_node(attribute_node).get(_attribute))


func _on_Console_text_entered(input : String):
	if input.count("=") > 0:
		var attribute = input.split("=")[0]
		var params = input.split("=")[1]
		if params.count(",") > 0:
			var x = params.split(",")[0]
			var y = params.split(",")[1]
			var z = params.split(",")[2]
			params = Vector3(x,y,z)
		# check for valid attribute
		if attribute in attr2label_dict.keys():
			if attribute.count("/") > 0:
				var i = attribute.find_last("/")
				var attribute_node = attribute.substr(0, i)
				var _attribute = attribute.substr(i+1)
				get_parent().get_node(attribute_node).set(_attribute, params)
			else:
				if attribute.count(".") > 0:
					get_parent()[attribute.split(".")[0]][attribute.split(".")[1]] = params
				else:
					get_parent().set(attribute, params)
		else:
			print("not a valid attribute/command")
