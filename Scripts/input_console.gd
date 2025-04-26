extends CanvasLayer

var commands = [
	"move to",
	"attack"
]

func _ready() -> void:
	%LineEdit.grab_focus()

func _on_line_edit_text_submitted(input: String) -> void:
	%LineEdit.text = ""
	for command in commands:
		if command in input:
			var keywords = input.split(' ')
			match command:
				"move to":
					var target = keywords[-1]
					get_tree().call_group(keywords[0], "move_to", Cords.translate(target))
				"attack":
					var target = keywords[-1]
					get_tree().call_group(keywords[0], "attack", get_tree().get_first_node_in_group(target))
