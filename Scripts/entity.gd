class_name Entity
extends Node2D

signal died
@export var max_hp := 100.0
var hp := max_hp:
	set = set_hp

func take_damage(damage : float) -> void:
	hp -= damage
	if hp <= 0:
		die()

func die() -> void:
	queue_free()
	died.emit()

func set_hp(new_hp):
	pass
