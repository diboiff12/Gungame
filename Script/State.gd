#모든 상태 스크립트의 기본 클래스.
#이 클래스를 확장하고 함수를 오버라이드해서 특정 상태를 구현하면 됨.
class_name State extends Node

#상태가 끝나고 다른 상태로 전이하고 싶을 때 발산한다.
signal finished(next_state_path: String, data: Dictionary)

#임의의 입력을 받았을 때 상태머신에서 호출한다.
func handle_input(_event: InputEvent) -> void:
	pass

#상태머신에서 프레임마다 실행된다.
func update(_delta: float) -> void:
	pass

#상태머신에서 프레임마다 실행된다.
func physics_update(_delta: float) -> void:
	pass

#활성 상태를 변경할 때 상태머신에서 실행된다. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter(previous_state_path: String, data := {}) -> void:
	pass

#활성 상태를 변경하기 전에 상태머신에서 실행된다. 
#해당 상태를 한 번 청소해준다. 예) 낙하 상태에서 중력값을 줄여서 쓰고 있었다면
#원래 값으로 돌려놓는다.
func exit() -> void:
	pass
