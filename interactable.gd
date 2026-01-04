@abstract 
class_name Interactable extends Area2D
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and $Label.visible:
		interact()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		$Label.visible = true
		
@abstract
func interact() -> void
	

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		$Label.visible = false
