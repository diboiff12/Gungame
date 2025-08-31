class_name StateMachine extends Node

@export var initial_state: State = null

#시작 상태 정의됨 : 상태를 시작 상태로. else:첫번째 자식을 시작 상태로.
@onready var state: State = (func get_initial_state() -> State:
	return initial_state if initial_state != null else get_child(0)
).call()

var saved_delta = 1.0 / Engine.get_frames_per_second()
var saved_physics_delta = 1.0 / Engine.get_frames_per_second()

func _ready() -> void:
	#개별 상태들이 finished를 발산하면 전이 함수 실행
	for state_node in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)

	await owner.ready
	state.enter("")


func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	saved_delta = delta
	state.update(delta)


func _physics_process(delta: float) -> void:
	saved_physics_delta = delta
	state.physics_update(delta)


func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	#매개변수로 들어온 이름에 해당하는 상태가 없으면 오류 발생.
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return

	#이전 상태 퇴장, 다음 상태 입장
	var previous_state_path := state.name
	state.exit()
	state = get_node(target_state_path)
	state.enter(previous_state_path, data)
	state.update(saved_delta)
	state.physics_update(saved_physics_delta)
