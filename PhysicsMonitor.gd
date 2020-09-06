extends Panel

# attributes of the parent or specified children of the parent
var attributes = ["acceleration", "velocity", "direction", "rotation_speed", 
	"transform.basis", "transform.origin",
	"Jump/jump_velocity", "Walk/walk_acceleration", "Walk/friction", "Walk/max_walk_speed",]

func _ready():
	for attribute in attributes:
		var label = Label.new()
		# We immediately have the attribute
		if attribute.count("/") > 0:
			# Seperate location node and attribute name
			var i = attribute.find_last("/")
			var attribute_node = attribute.substr(0, i)
			attribute = attribute.substr(i+1)
		
		# set node name of label
		if attribute.count(".") > 0:
			# Node names can't contain "."
			label.name = str(attribute.replace(".", "_"))
		else:
			label.name = attribute
		label.size_flags_horizontal = SIZE_EXPAND_FILL
		$VBoxContainer.add_child(label, true)


func _physics_process(delta):
	for attribute in attributes:
		# if a node is provided (Node/attribute)
		if attribute.count("/") > 0:
			var i = attribute.find_last("/")
			var attribute_node = attribute.substr(0, i)
			attribute = attribute.substr(i+1)
			# i.e. attribute is transform.origin
			if attribute.count(".") > 0:
				get_node("VBoxContainer/" + attribute.replace(".","_")).set_text(attribute + ": " + str(get_parent().get_node(attribute_node).get(attribute.split(".")[0])[attribute.split(".")[1]]))
			else:
				get_node("VBoxContainer/" + attribute).set_text(attribute + ": " + str(get_parent().get_node(attribute_node).get(attribute)))
		else: 
			if attribute.count(".") > 0:
				get_node("VBoxContainer/" + attribute.replace(".","_")).set_text(attribute + ": " + str(get_parent().get(attribute.split(".")[0])[attribute.split(".")[1]]))
			else:
				get_node("VBoxContainer/" + attribute).set_text(attribute + ": " + str(get_parent().get(attribute)))
			
