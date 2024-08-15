extends Node2D

const ICONS := {
	"X": "res://assets/X.png",
	"O": "res://assets/O.png"
}
var areas := []
var turn := false
var turn_1 : String
var turn_2 : String

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false
	randomize()
	var available_icons = ICONS.duplicate()
	turn_1 = available_icons.keys().pick_random()
	available_icons.erase(turn_1)
	turn_2 = available_icons.keys().pick_random()
	
	for child in $"Game Area/Areas".get_children():
		child.connect("area_clicked", _on_area_clicked)
		areas.append(child)

func _on_area_clicked(area):
	area.set_icon(ICONS[get_turn()])
	check_places()
	
func get_turn():
	turn = !turn
	if turn: return turn_1
	else: return turn_2
	
func check_places():
	# Check columns
	for i in 3:
		if check_equivalence(areas[i], areas[i+3], areas[i+6]): game_over()
	# Check rows
	for i in 3:
		var sliced_array = areas.slice(i*3,i*3+3)
		if check_equivalence(sliced_array[0], sliced_array[1], sliced_array[2]): game_over()
	# Check diagonals
	if check_equivalence(areas[0], areas[4], areas[8]): game_over()
	elif check_equivalence(areas[2], areas[4], areas[6]): game_over()
	
func check_equivalence(area1, area2, area3):
	if area1.is_set():
		if area1.is_set() == area2.is_set():
			if area2.is_set() == area3.is_set():
				return true
				
func game_over():
	get_tree().paused = true
	
func _on_restart_pressed():
	get_tree().reload_current_scene()
func _on_exit_pressed():
	get_tree().quit()
