extends CanvasLayer
signal start_game
signal back_to_menu

@export var level_entry_ps: PackedScene

var current_page = 0
var card_size

func _ready():
	
	var level_entry = level_entry_ps.instantiate()
	level_entry.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	level_entry.size_flags_vertical = Control.SIZE_EXPAND_FILL
	$SelectLevelMenu/LevelEntryContainer/LevelEntryGrid.add_child(level_entry)
	card_size = Vector2(level_entry.size)
	$SelectLevelMenu/LevelEntryContainer/LevelEntryGrid.remove_child(level_entry)
	level_entry.queue_free()
	

func _process(delta):
	pass

func _on_start_button_pressed():
	start_game.emit()

func _on_quit_button_pressed():
	get_tree().quit()

func _on_back_to_menu_button_pressed():
	back_to_menu.emit()

func set_entries():
	var entries_added = 0
	var puzzle_set_idx = current_page * 4
	var last_puzzle_set_idx = puzzle_set_idx + 4
	
	var puzzle_set_size = PuzzleSet.puzzles.size()
	
	while puzzle_set_idx < last_puzzle_set_idx and puzzle_set_idx < puzzle_set_size:
		var level_entry = level_entry_ps.instantiate()
		level_entry.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		level_entry.size_flags_vertical = Control.SIZE_EXPAND_FILL
		level_entry.set_label(PuzzleSet.puzzles[puzzle_set_idx])
		level_entry.add_to_group('cards')
		$SelectLevelMenu/LevelEntryContainer/LevelEntryGrid.add_child(level_entry)
		
		puzzle_set_idx += 1
	
	if puzzle_set_idx % 4 > 0:
		
		var placeholders_to_add = 4 - (puzzle_set_idx % 4)	
		
		while placeholders_to_add > 0:
			var pc = Control.new()
			pc.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			pc.size_flags_vertical = Control.SIZE_EXPAND_FILL
			pc.custom_minimum_size = Vector2(336, 110)
			$SelectLevelMenu/LevelEntryContainer/LevelEntryGrid.add_child(pc)
			placeholders_to_add -= 1


func _on_button_right_pressed():
	current_page += 1
	var grid_items = $SelectLevelMenu/LevelEntryContainer/LevelEntryGrid.get_children()
	for item in grid_items:
		$SelectLevelMenu/LevelEntryContainer/LevelEntryGrid.remove_child(item)
		item.queue_free()
	set_entries()


func _on_button_left_pressed():
	if current_page > 0:
		current_page -= 1
		var grid_items = $SelectLevelMenu/LevelEntryContainer/LevelEntryGrid.get_children()
		for item in grid_items:
			$SelectLevelMenu/LevelEntryContainer/LevelEntryGrid.remove_child(item)
			item.queue_free()
		set_entries()

func get_card_at_position(position):
	for card in get_tree().get_nodes_in_group("cards"):
		if position.x > card.position.x && position.x < (card.position.x + card.size.x) && \
			position.y > card.position.y && position.y < (card.position.y + card.size.y):
			return card
	return null
