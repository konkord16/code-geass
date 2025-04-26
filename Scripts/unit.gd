class_name Unit
extends Node2D

var squad : String
var number : String
@export var alignment : String
@export var attack_range : float
@export var max_hp := 100
@export var move_speed := 5.0
var hp := max_hp
var velocity := Vector2.ZERO
var attack_target : Node2D
var follow := false
var shooting := false
var moving:= false
var move_target : Vector2
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	%Label.text = squad+number
	add_to_group(squad+number)

func _physics_process(delta: float) -> void:
	if attack_target:
		var target = attack_target.global_position
		if global_position.distance_to(target) > attack_range and follow:
			move_to(target)
		elif global_position.distance_to(target) < attack_range*0.8:
			_on_target_reached()
			#shoot
	if moving:
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		%Polygon2D.rotation = dir.angle()
		velocity = dir * move_speed
		global_position += velocity

func move_to(target : Vector2) -> void:
	moving = true
	nav_agent.target_position = target

func _on_target_reached() -> void:
	moving = false

func attack(target : Node2D) -> void:
	attack_target = target


func _on_timer_timeout() -> void:
	attack_target.take_damage
	
func take_damage(damage : float) -> void:
	pass
