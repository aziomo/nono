extends Object
class_name Puzzle

var _name := "unnamed"
var _board := [] 

func get_board_width() -> int :
	return _board.size()
	
func get_board_height() -> int :
	return _board[0].size()
