extends Camera


func fps_mode():
	pass


# possible implementation of a camera following player

#export var min_distance = 0.5
#export var max_distance = 5
#export var angle_v_adjust = 0.0
#export var autoturn_ray_aperture = 25
#export var autoturn_speed = 50
#
#var collision_exception = []
#var max_height = 5
#var min_height = 2
#
#func _ready():
#	# Find collision exceptions for ray.
#	var node = self
#	while node:
#		if node is RigidBody:
#			collision_exception.append(node.get_rid())
#			break
#		else:
#			node = node.get_parent()
#	set_physics_process(true)
#	# This detaches the camera transform from the parent spatial node.
#	# Parent transforms will no longer effect this node
#	set_as_toplevel(true)
#
#func _physics_process(dt):
#	var target = get_parent().get_global_transform().origin
#	var pos = get_global_transform().origin
#
#	var delta = pos - target
#
#	# Regular delta follow.
#
#	# Check ranges.
#	if delta.length() < min_distance:
#		delta = delta.normalized() * min_distance
#	elif  delta.length() > max_distance:
#		delta = delta.normalized() * max_distance
#
#	# Check upper and lower height.
#	if delta.y > max_height:
#		delta.y = max_height
#	if delta.y < min_height:
#		delta.y = min_height
#
#	# Ray Tracing stuff
#	# Check autoturn.
#	var ds = PhysicsServer.space_get_direct_state(get_world().get_space())
#
#	var col_left = ds.intersect_ray(target, target + Basis(Vector3.UP, deg2rad(autoturn_ray_aperture)).xform(delta), collision_exception)
#	var col = ds.intersect_ray(target, target + delta, collision_exception)
#	var col_right = ds.intersect_ray(target, target + Basis(Vector3.UP, deg2rad(-autoturn_ray_aperture)).xform(delta), collision_exception)
#
#	if !col.empty():
#		# If main ray was occluded, get camera closer, this is the worst case scenario.
#		delta = col.position - target
#	elif !col_left.empty() and col_right.empty():
#		# If only left ray is occluded, turn the camera around to the right.
#		delta = Basis(Vector3.UP, deg2rad(-dt * autoturn_speed)).xform(delta)
#	elif col_left.empty() and !col_right.empty():
#		# If only right ray is occluded, turn the camera around to the left.
#		delta = Basis(Vector3.UP, deg2rad(dt  *autoturn_speed)).xform(delta)
#	# Do nothing otherwise, left and right are occluded but center is not, so do not autoturn.
#
#	# Apply lookat.
#	if delta == Vector3():
#		delta = (pos - target).normalized() * 0.0001
#
#	pos = target + delta
#
#	look_at_from_position(pos, target, Vector3.UP)
#
#	# Turn a little up or down.
#	var t = get_transform()
#	t.basis = Basis(t.basis[0], deg2rad(angle_v_adjust)) * t.basis
#	set_transform(t)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#
#func _physics_process(delta):
#	var target = get_parent().global_transform.origin
#	var pos = global_transform.origin
#	var up = Vector3(0,1,1)
#
#	var offset = pos - target
#
#	offset = offset.normalized()*distance
#	offset.y = height
#	pos = target + offset
#
#	look_at_from_position(pos, target, up)

#func set_camera():
#	transform.basis = Basis()
#
##func _unhandled_input(event):
##	if event.
#
#func move_camera():
#	transform.basis.x = transform.basis.z
#	transform.basis.z = Vector3(0, 0, 0)
#	global_transform.looking_at(get_parent().global_transform, Vector3.UP)
	# Side View
	#rotate(Vector3(0,1,0), -90)


#	transform.basis = Basis(Basis.FLIP_Z)
#	var quat = Quat()
#	var basis = Basis()
#	# Contains the following default values:
#	transform.basis.x = Vector3(1, 0, 0) # Vector pointing along the X axis
#	transform.basis.y = Vector3(0, 1, 0) # Vector pointing along the Y axis
#	transform.basis.z = Vector3(0, 0, 1) # Vector pointing along the Z axis
#
#	# or
#	basis = Basis(Basis.IDENTITY)
#
#	# It is possible to rotate a transform, either by multiplying its basis
#	# by another (this is called accumulation), or by using the rotation methods.
#
#	# Rotate the transform about the X axis
#	transform.basis = Basis(Vector3(1, 0, 0), PI) * transform.basis
#	# shortened
#	transform.basis = transform.basis.rotated(Vector3(1, 0, 0), PI)
#
#	# A method in Spatial simplifies this:
#	# This rotates the node relative to the parent node.
#	# Rotate the transform in X axis
#	rotate(Vector3(1, 0, 0), PI)
#	# shortened
#	rotate_x(PI)
#
#	# To rotate relative to object space (the node’s own transform), use the following:
#	# Rotate locally
#	rotate_object_local(Vector3(1, 0, 0), PI)
#
##Precision errors
##Doing successive operations on transforms will result in a loss of precision due to floating-point error. This means the scale of each axis may no longer be exactly 1.0, and they may not be exactly 90 degrees from each other.
##
##If a transform is rotated every frame, it will eventually start deforming over time. This is unavoidable.
##
##There are two different ways to handle this. The first is to orthonormalize the transform after some time (maybe once per frame if you modify it every frame):
#
#	transform = transform.orthonormalized()
#	transform = transform.orthonormalized()
#	transform = transform.scaled(scale)
#
#	# spawn a bullet
##	bullet.transform = transform
##	bullet.speed = transform.basis.z * BULLET_SPEED
#
## Get the direction vector from player to enemy
##	var direction = enemy.transform.origin - player.transform.origin
##	if direction.dot(enemy.transform.basis.z) > 0:
##	    enemy.im_watching_you(player)
#
#	# Convert basis to quaternion, keep in mind scale is lost
#	var a = Quat(transform.basis)
#	var b = Quat(Basis(Basis.FLIP_Y))
#	# Interpolate using spherical-linear interpolation (SLERP).
#	var c = a.slerp(b,0.5) # find halfway point between a and b
#	# Apply back
#	transform.basis = Basis(c)

