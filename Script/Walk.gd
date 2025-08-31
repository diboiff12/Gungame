extends Monster_State

var velocity = 100

func enter(previous_state_path: String, data := {}) -> void:
	monster.sprite.play("walk")


func physics_update(_delta: float) -> void:
	monster.position.x += velocity*_delta
