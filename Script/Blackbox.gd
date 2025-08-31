extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready():
	size = get_viewport().get_visible_rect().size
	get_viewport().size_changed.connect(resize)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func resize():
	size = get_viewport().get_visible_rect().size
	#position = get_viewport().position
