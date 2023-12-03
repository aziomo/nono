extends Node

@export var tile_scene: PackedScene

var focused_tile
var focused_card
var tile_drag_edit_mode = null
var prev_tile_state := Enums.TILE_STATE.CLEAR
var mouse_pressed = false
var mbutton_pressed = null
#var puzzles = []

func _ready():
	$TileBoard.connect('game_result', _on_tile_board_game_result)
	PuzzleSet.import_puzzles_from_file()
	
var second_init = false
	
func _on_hud_start_game():
	
	var testing_game = false
	if testing_game:
		init_tileboard()
		$HUD/MainMenu.hide()
		$TileBoard.show()
	else:
		$HUD/MainMenu.hide()
		$HUD.set_entries()
		$HUD/SelectLevelMenu.show()
	
	
func init_tileboard():
	var puzzle_array = $TileBoard.puzzle_array
	var tile = tile_scene.instantiate()
	var pos_x = $Background.size.x / 2 - (puzzle_array[0].size() * tile.width() / 2)
	var pos_y = $Background.size.y / 2 - (puzzle_array.size() * tile.height() / 2)
	
	tile.free()
	$TileBoard.initialize_tiles()
	$TileBoard.position = Vector2(pos_x, pos_y)
		
	
func _process(delta):
	pass
	
func _on_tile_board_game_result(result):
	if result == 1:
		$HUD/MessageBox.show()
	
func _on_hud_back_to_menu():
	
	var tiles = get_tree().get_nodes_in_group('tiles')
	for t in tiles:	t.queue_free()
	var tile_labels = get_tree().get_nodes_in_group('tile_labels')
	for tl in tile_labels: tl.queue_free()
	$TileBoard.hide()
	$HUD/MessageBox.hide()
	$HUD/MainMenu.show()
	
func register_points_change():
	pass
	
func is_cursor_inbounds(event):
	var tileboard_cursor_pos = event.position - $TileBoard.position
	return tileboard_cursor_pos.x > 0 && tileboard_cursor_pos.y > 0
	
func _input(event):
	
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()
		
	if event is InputEventMouseButton:
		pass
		
		
	if event is InputEventMouseMotion:
#
					
		if $HUD/SelectLevelMenu.visible:
			
			if is_instance_valid(focused_card) && focused_card.highlighted:
				focused_card.highlighted = false
			var offset = Vector2($HUD/SelectLevelMenu/LevelEntryContainer/LevelEntryGrid.position.x, $HUD/SelectLevelMenu/LevelEntryContainer.position.y)
			focused_card = $HUD.get_card_at_position(event.position - offset)
			if focused_card:
				focused_card.highlighted = true





