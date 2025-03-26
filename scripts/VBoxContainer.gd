extends VBoxContainer

const WORLD = preload("res://scenes/world.tscn")

func _on_play_pressed():
	get_tree().change_scene_to_packed(WORLD)


func _on_quit_pressed():
	get_tree().quit()
