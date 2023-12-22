extends Node

var selected_puzzle
var puzzles := {}

func import_puzzles_from_file():
	var file = FileAccess.open("puzzles.txt", FileAccess.READ)
	var line = file.get_line()
	
	while !file.eof_reached():
		var puzzle = Puzzle.new()
		
		if line.contains('name='):
			puzzle._name = line.get_slice('name=', 1)
		line = file.get_line()
		if line.contains('board='):
			line = file.get_line()
			while !line.contains('end'):
				var x = Array(line.split()).map(func(digit): return int(digit)) 
				puzzle._board.push_back(x)
				line = file.get_line()
			puzzles[puzzle._name] = puzzle
