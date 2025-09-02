extends CharacterBody2D
class_name Monster


var speed = 200.0

var attack_distance = 100

var hp = 100

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var sprite:AnimatedSprite2D
@export var statemachine:StateMachine


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()


func damaged(angle:Vector2, damage:float, force:float) -> void:
	statemachine.state.finished.emit(statemachine.state.KNOCKBACK)
	statemachine.get_node(statemachine.state.KNOCKBACK).angle = angle
	statemachine.get_node(statemachine.state.KNOCKBACK).force = force
