extends Node
signal setting_change(setting_name, setting_value)

var cfg = ConfigFile.new()

func _ready():
	cfg.load("res://config.cfg")

func set_option(key, value) -> void:
	cfg.set_value("settings", key, value)
	setting_change.emit(key, value)
	cfg.save("res://config.cfg")
	
func get_option(key) -> Variant:
	return cfg.get_value("settings", key)
	
func set_hl_square(hl: bool) -> void:
	cfg.set_value("settings", "hl_square", hl)
	cfg.save("res://config.cfg")
	
