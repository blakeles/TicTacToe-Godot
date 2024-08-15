extends Area2D

signal area_clicked

var set := false # If the area has been clicked in already
var icon := ""

func _on_input_event(viewport, event, shape_idx):
	if InputEventScreenTouch && event.is_pressed():
		if !set: area_clicked.emit(self)

func set_icon(icon_path : String):
	icon = icon_path
	$'Sprite2D'.texture = load(icon_path)
	scale = Vector2i(1,1)
	set = true
	
func is_set():
	return icon
