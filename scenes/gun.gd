extends Node2D

const bullet = preload("uid://cgiwjxpuksgxr")
@onready var muzzel: Marker2D = $Marker2D
@onready var firerate: Timer = $Firerate
var canfire : bool = true
var orbit_distance: float 
func _ready() -> void:
	orbit_distance = global_position.distance_to(get_parent().global_position)
func _process(_delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var distance_to_mouse = global_position.distance_to(mouse_pos)
	
	var direction = (mouse_pos - get_parent().global_position).normalized()
	global_position = get_parent().global_position + (direction * orbit_distance)
	if distance_to_mouse > 5.0:
		look_at(mouse_pos)
	
	rotation_degrees = wrapf(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
	
	if Input.is_action_just_pressed("fire") and canfire:
		fire()
	
func fire() -> void:
		$AudioStreamPlayer2D.play()
		firerate.start()
		canfire = !canfire
		var bullet_instance = bullet.instantiate()
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = muzzel.global_position
		bullet_instance.rotation = rotation

func _on_firerate_timeout() -> void:
	canfire = !canfire
