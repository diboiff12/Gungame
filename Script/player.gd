extends CharacterBody2D


@export var SPEED = 600.0
@export var JUMP_VELOCITY = -1000.0
@export var deceleration = 100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")*4

@export var sprite:Sprite2D
@export var bullet_scene:PackedScene
@export var ground_detector:RayCast2D

@export var fire_rate = 2
var fire_cooldown = 0

@export var recoil_force = 1000

var base_velocity = Vector2.ZERO
var external_velocity = Vector2.ZERO

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		
		if base_velocity.y < 0:
			base_velocity.y += gravity * delta
		else:
			base_velocity.y += gravity * delta 


	# Handle Jump.
	if Input.is_action_pressed("ui_up") and ground_detector.is_on_floor:
		base_velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		base_velocity.x = direction * SPEED
	else:
		base_velocity.x = move_toward(base_velocity.x, 0, SPEED)

	#기본 이동으로 인한 속도 변화를 모두 적용한 뒤에 외부 속도를 더해야 한다.
	velocity = external_velocity + base_velocity
	external_velocity = external_velocity.move_toward(Vector2.ZERO, deceleration)

	move_and_slide()

	#총구가 마우스 방향을 바라봄
	rotation = (get_global_mouse_position()-position).angle()

	shoot()


func shoot():
	fire_cooldown = move_toward(fire_cooldown, 0, 1)
	if Input.is_action_pressed("shoot"):
		if fire_cooldown > 0:
			return
		else:
			fire_cooldown = 60.0/fire_rate
		
		#총알 생성, 초기 설정
		var bullet = bullet_scene.instantiate()
		bullet.rotation = rotation
		bullet.position = position
		get_viewport().get_child(0).call_deferred("add_child", bullet)
		
		#반동
		external_velocity.x += (Vector2.RIGHT.rotated(rotation+PI)*recoil_force).x
		base_velocity.y = (Vector2.RIGHT.rotated(rotation+PI)*recoil_force).y
