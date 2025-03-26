extends CharacterBody3D


const SPEED = 8.0
const JUMP_VELOCITY = 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 20
var sensitivity = 0.002
var selection = 6

@onready var camera_3d = $Camera3D
@onready var ray_cast_3d = $Camera3D/RayCast3D
@onready var hot_bar = $"Hot bar"


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	hot_bar.select(0)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation.y = rotation.y - event.relative.x * sensitivity
		camera_3d.rotation.x = camera_3d.rotation.x - event.relative.y * sensitivity
		camera_3d.rotation.x = clamp(camera_3d.rotation.x , deg_to_rad(-90) , deg_to_rad(80))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left ", "right", "up", "down ")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0
		velocity.z = 0
	
	if Input.is_action_just_pressed("left click"):
		if ray_cast_3d.is_colliding():
			if ray_cast_3d.get_collider().has_method("destroy_block"):
				ray_cast_3d.get_collider().destroy_block(ray_cast_3d.get_collision_point() - ray_cast_3d.get_collision_normal())
	
	if Input.is_action_just_pressed("right click"):
		if ray_cast_3d.is_colliding():
			if ray_cast_3d.get_collider().has_method("place_block"):
				ray_cast_3d.get_collider().place_block(ray_cast_3d.get_collision_point() + ray_cast_3d.get_collision_normal() , selection)
	
	#handle block selection
	if Input.is_action_just_pressed("1"):
		selection = 1
		hot_bar.select(0)

	if Input.is_action_just_pressed("2"):
		selection = 2
		hot_bar.select(1)

	if Input.is_action_just_pressed("3"):
		selection = 3
		hot_bar.select(2)
		
	if Input.is_action_just_pressed("4"):
		selection = 4
		hot_bar.select(3)

	if Input.is_action_just_pressed("5"):
		selection = 5
		hot_bar.select(4)

	if Input.is_action_just_pressed("6"):
		selection = 0
		hot_bar.select(5)
		
	if Input.is_action_just_pressed("7"):
		selection = 7
		hot_bar.select(6)

	if Input.is_action_just_pressed("8"):
		selection = 6
		hot_bar.select(7)

	move_and_slide()
