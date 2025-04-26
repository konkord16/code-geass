extends CanvasLayer

var commands = [
	"move to"
]

func _on_line_edit_text_submitted(input: String) -> void:
	%LineEdit.text = ""
	#for command in commands:
		#if command in input:
			#match command:
				#"move to":
					#
	if "move to" in input:
		var keywords = input.split(' ')
		var target = keywords[-1]
		get_tree().call_group(keywords[0], "move_to", Cords.translate(target))
		print(target)
