extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:

	var direction := Input.get_vector("left", "right","up","down").normalized()
	if direction:
		velocity = direction * SPEED
		$Sprite2D.flip_h = direction.x > 0.5
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
	print(direction)
