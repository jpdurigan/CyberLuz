class_name DetectionArea
extends Area2D

signal player_entered
signal player_exited
signal enemy_entered
signal enemy_exited
signal entered
signal exited

var player: Player = null
var enemy: Enemy = null


func _ready():
	connect("area_entered", self, "_on_area_entered")
	connect("area_exited", self, "_on_area_exited")
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")


func has_overlapping_player() -> bool:
	return player != null

func get_overlapping_player() -> Player:
	return player

func has_overlapping_enemy() -> bool:
	return enemy != null

func get_overlapping_enemy() -> Enemy:
	return enemy


func _on_area_entered(area: Area2D) -> void:
	player = area.owner as Player
	if player:
		emit_signal("player_entered")
	
	enemy = area.owner as Enemy
	if enemy:
		emit_signal("enemy_entered")
	
	emit_signal("entered")

func _on_area_exited(area: Area2D) -> void:
	if area.owner == player:
		player = null
		emit_signal("player_exited")
	
	if area.owner == enemy:
		enemy = null
		emit_signal("enemy_exited")
	
	emit_signal("exited")

func _on_body_entered(body: Node) -> void:
	player = body as Player
	if player:
		emit_signal("player_entered")
	
	enemy = body as Enemy
	if enemy:
		emit_signal("enemy_entered")
	
	emit_signal("entered")

func _on_body_exited(body: Node) -> void:
	if body == player:
		player = null
		emit_signal("player_exited")
	
	if body == enemy:
		enemy = null
		emit_signal("enemy_exited")
	
	emit_signal("exited")
