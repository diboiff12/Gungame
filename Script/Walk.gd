extends Monster_State

var speed
var attack_distance

func enter(previous_state_path: String, data := {}) -> void:
	monster.sprite.play(self.name)
	
	speed = monster.speed
	attack_distance = monster.attack_distance


func physics_update(_delta: float) -> void:
	if monster.position.x < player.position.x:
		monster.position.x += speed*_delta
	else:
		monster.position.x -= speed*_delta
	monster.sprite.flip_h = monster.position.x < player.position.x

	if attack_distance**2 > monster.position.distance_squared_to(player.position):
		finished.emit(ATTACK)
