extends Monster_State


var angle = Vector2.ZERO
var force = 0

func enter(previous_state_path: String, data := {}) -> void:
	monster.sprite.play(self.name)
	if !monster.sprite.animation_finished.is_connected(change_to_walk):
		monster.sprite.animation_finished.connect(change_to_walk)


func physics_update(_delta: float) -> void:
	monster.position.x += force*_delta * angle.normalized().x
	force *= 0.9


func change_to_walk():
	finished.emit(WALK)
