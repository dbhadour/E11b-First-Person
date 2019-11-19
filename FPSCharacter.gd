extends KinematicBody
onready var camera = $Pivot/Camera
var gravity = -30
var max_speed = 8
var mouse_sensitivity = 0.002


var velocity = Vector3()
var jump = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
func get_input():
	jump = false
	if Input.is_action_just_pressed("jump"):
		jump = true
	var input_dir = Vector3()
	
	
	if Input.is_action_pressed("move_forward"):
        input_dir += -camera.global_transform.basis.z     
		
	if Input.is_action_pressed("move_back"):
        input_dir += camera.global_transform.basis.z
    
	if Input.is_action_pressed("strafe_left"):
        input_dir += -camera.global_transform.basis.x
    
	if Input.is_action_pressed("strafe_right"):
        input_dir += camera.global_transform.basis.x
    
	input_dir = input_dir.normalized()
    
	return input_dir
	
func _unhandled_input(event):
	
	
	if event is InputEventMouseMotion and Input.get_mouse_model() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
	    
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		$Pivot.rotation.x =  clamp($Pivot.rotation.x, -1.2, 1.2)
		
func _physics_process(delta):
	var jump_speed = 12
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	
	velocity = move_and_slide(velocity, Vector3.UP, true)
	if jump and is_on_floor():
		velocity.y = jump_speed
	
	
		
		
