extends Sprite2D


var T_0	= preload("res://assets/0.png")
var T_1	= preload("res://assets/1.png")
var T_2	= preload("res://assets/2.png")
var T_3 = preload("res://assets/3.png")
var T_4 = preload("res://assets/4.png")
var T_5 = preload("res://assets/5.png")
var T_6 = preload("res://assets/6.png")
var T_7 = preload("res://assets/7.png")
var T_8 = preload("res://assets/8.png")
var T_9 = preload("res://assets/9.png")


var highlighted:
	set(value):
		highlighted = value
		material.set_shader_parameter("brightness", 0.2 if highlighted else 0.0)


@export var value: int:
	set(x):
		value = x
		match value:
			0: set_texture(T_0)
			1: set_texture(T_1)
			2: set_texture(T_2)
			3: set_texture(T_3)
			4: set_texture(T_4)
			5: set_texture(T_5)
			6: set_texture(T_6)
			7: set_texture(T_7)
			8: set_texture(T_8)
			9: set_texture(T_9)

func _init():
	value = 0

func _process(delta):
	pass

func height():
	return get_texture().get_height() * scale.y
	
func width():
	return get_texture().get_width() * scale.x

