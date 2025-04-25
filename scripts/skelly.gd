extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -250.0

@onready var animate = $AnimatedSprite2D

var is_down = false
var is_jumping = false
var is_attacking = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		if not is_jumping:
			animate.play("fall")
	else:
		is_jumping = false

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animate.play("jump")
		is_jumping = true
	
	if Input.is_action_just_pressed("down"):
		is_down = true
		animate.play("down")
	else:
		is_down = false

	# Get the input direction and handle the movement/decel	eration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		
		if is_down:
			animate.play("crawl")
		else:
			if is_on_floor() and not is_jumping:
				animate.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	#if not is_down and not is_jumping and not is_attacking:
		#animate.play("idle")
	
	if Input.is_action_just_pressed("left"):
		animate.flip_h = true
	elif Input.is_action_just_pressed("right"):
		animate.flip_h = false
	
	if Input.is_action_pressed("interact"):
		animate.play("interact")
		is_attacking = true
	else:
		is_attacking = false

	move_and_slide()
