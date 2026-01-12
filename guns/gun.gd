extends Node2D
class_name Gun

const bullet = preload("uid://cgiwjxpuksgxr")
@onready var firerate: Timer = $Firerate

@export var automatic : bool = false
var bullet_spawners : Array[Marker2D]
var canfire : bool = true
var orbit_distance: float 

func _ready() -> void:
	for child in get_children():
		if child.name.to_lower().contains("bulletspawn"):
			bullet_spawners.append(child)
	orbit_distance = global_position.distance_to(get_parent().global_position)
	
func _process(_delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var distance_to_mouse = global_position.distance_to(mouse_pos)
	
	var direction = (mouse_pos - get_parent().global_position).normalized()
	global_position = get_parent().global_position + (direction * orbit_distance)
	if distance_to_mouse > 2.0:
		look_at(mouse_pos)
	
	rotation_degrees = wrapf(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
	if !canfire:
		if Input.is_action_just_pressed("fire") and canfire:
			fire()
	else:
		if Input.is_action_pressed("fire") and canfire:
			fire()
	
func fire() -> void:
		$AudioStreamPlayer2D.play()
		firerate.start()
		canfire = !canfire
		for i in bullet_spawners:
			print(i)
			var bullet_instance = bullet.instantiate()
			get_tree().root.add_child(bullet_instance)
			bullet_instance.global_position = i.global_position
			bullet_instance.rotation = i.global_rotation

func _on_firerate_timeout() -> void:
	canfire = !canfire
