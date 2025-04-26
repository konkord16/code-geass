extends Node2D

@export var grid_size := 7
@export var cell_size := 320.0
var alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

func _ready() -> void:
	for i in range(grid_size):
		var label = Label.new()
		label.text = alphabet[i]
		label.global_position = Vector2(cell_size/2 + i * cell_size, 16)
		add_child(label)
		
	for i in range(grid_size):
		var label = Label.new()
		label.text = str(i + 1)
		label.global_position = Vector2(20, cell_size/2 + i * cell_size)
		add_child(label)
	print(Cords.translate("B3"))
