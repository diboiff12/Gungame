extends Area2D

@export var speed = 2000

@export var damage = 30
@export var force = 200

@export var bullet_debris_scene:PackedScene
@export var wall_detector:RayCast2D
# Called when the node enters the scene tree for the first time.
func _ready():
	self.body_entered.connect(on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2.RIGHT.rotated(rotation)*speed*delta

	if wall_detector.is_colliding():
		if wall_detector.get_collider() is TileMapLayer:
			if (speed*delta)**2 > position.distance_squared_to(wall_detector.get_collision_point()):
				collide_with_wall()
		elif wall_detector.get_collider() is CharacterBody2D:
			if (speed*delta)**2 > position.distance_squared_to(wall_detector.get_collision_point()):
				wall_detector.get_collider().damaged(Vector2.RIGHT.rotated(rotation), damage, force)


#레이캐스트만으로는 벽에 딱 붙어서 쏜 총알을 감지할 수 없기 때문에 불가피하게 영역 병용
func on_body_entered(body):
	if body is TileMapLayer:
		var bullet_debris = bullet_debris_scene.instantiate()
		bullet_debris.rotation = rotation+PI
		bullet_debris.position = position
		get_viewport().get_child(0).call_deferred("add_child", bullet_debris)
		queue_free()


func collide_with_wall():
	var bullet_debris = bullet_debris_scene.instantiate()
	bullet_debris.rotation = Vector2.RIGHT.rotated(rotation).bounce(wall_detector.get_collision_normal()).angle()
	bullet_debris.position = wall_detector.get_collision_point()
	get_viewport().get_child(0).call_deferred("add_child", bullet_debris)
	queue_free()
