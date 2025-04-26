extends Entity
class_name Unit

@export var squad : String
@export var number : String
@export var alignment : String
@export var move_speed := 5.0
@export var attack_range : float
@export var attack_damage : float
@export var attack_cd : float
var velocity := Vector2.ZERO
var attack_target : Entity
var follow := false
var moving:= false
var shooting := false
var move_target : Vector2
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	%Label.text = squad+number
	add_to_group(squad+number)
	%AttackCooldown.wait_time = attack_cd
	%ProgressBar.max_value = max_hp
	%ProgressBar.value = hp

func _physics_process(delta: float) -> void:
	if shooting:
		return
	if attack_target:
		if attack_target.hp <= 0:
			attack_target = null
			return
		var target = attack_target.global_position
		if global_position.distance_to(target) > attack_range and follow:
			move_to(target)
		elif global_position.distance_to(target) < attack_range * 0.8:
			_on_target_reached()
			try_shoot()
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

func attack(target : Entity) -> void:
	attack_target = target
	follow = true

func try_shoot() -> void:
	if %AttackCooldown.time_left > 0:
		return
	$AttackCooldown.start()
	shooting = true
	%Polygon2D.look_at(attack_target.global_position)
	%Particles.emitting = true

func _on_attack_cooldown_timeout() -> void:
	if attack_target:
		attack_target.take_damage(attack_damage)
	shooting = false
	%Particles.emitting = false
	

func set_hp(new_hp):
	hp = new_hp
	%ProgressBar.value = new_hp
