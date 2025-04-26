class_name Cords

static var alphabet = "abcdefghijklmnopqrstuvwxyz"

static func translate(cords : String, cell_size : float = 320) -> Vector2:
	var x = alphabet.find(cords[0])
	var y = int(cords[1]) - 1
	return Vector2(x * cell_size + cell_size/2, y * cell_size + cell_size/2)
	
