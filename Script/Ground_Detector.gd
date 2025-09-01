extends RayCast2D

var is_on_floor:bool
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		if get_collider() is TileMapLayer:
			is_on_floor = true
		else:
			is_on_floor = false
	else:is_on_floor= false

	rotation = -get_parent().rotation
