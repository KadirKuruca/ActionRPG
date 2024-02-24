extends Node2D

@onready var hearts_container = $CanvasLayer/HeartsContainer
@onready var player = $TileMap/Player

func _ready():
	hearts_container.set_max_hearts(player.max_health)


func _on_player_player_get_hit(current_health):
	hearts_container.update_hearts(current_health)
