#모든 상태 스크립트의 기본 클래스.
#이 클래스를 확장하고 함수를 오버라이드해서 특정 상태를 구현하면 됨.
class_name Monster_State extends State

var monster


func _ready() -> void:
	print(owner)
	await owner.ready
	monster = owner
