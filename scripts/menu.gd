extends Node3D

@onready var camra_pivi = $camrapivit

var rotation_speed = -8

func _process(delta):
	camra_pivi.rotation_degrees.y += delta * rotation_speed 
