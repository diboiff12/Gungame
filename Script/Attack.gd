extends Monster_State

var attack_distance
var is_attacking = false

func enter(previous_state_path: String, data := {}) -> void:
	monster.sprite.play(self.name)

	attack_distance = monster.attack_distance


func physics_update(_delta: float) -> void:
	if !is_attacking:
		if attack_distance**2 < monster.position.distance_squared_to(player.position):
			finished.emit(WALK)

	
