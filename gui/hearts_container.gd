extends HBoxContainer

@onready var HeartGuiClass = preload("res://gui/hearth_gui.tscn")

func set_max_hearts(max_hearts: int):
	for i in range(max_hearts):
		var heart = HeartGuiClass.instantiate()
		add_child(heart)
	
func update_hearts(current_health: int):
	var hearts = get_children()
	
	for i in range(hearts.size()):
		var whole = true if (i < current_health) else false
		hearts[i].update(whole)
