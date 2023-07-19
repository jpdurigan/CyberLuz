class_name DetectionArea
extends Area2D

signal player_entered
signal player_exited
signal enemy_entered
signal enemy_exited
signal civil_entered
signal civil_exited
signal entered
signal exited

var player: Player = null
var enemy: Enemy = null
var civil: Civil = null

func _ready():
	connect("area_entered", Callable(self, "_on_area_entered"))
	connect("area_exited", Callable(self, "_on_area_exited"))
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))


func has_overlapping_player() -> bool:
	return player != null

func get_overlapping_player() -> Player:
	return player

func has_overlapping_enemy() -> bool:
	return enemy != null

func get_overlapping_enemy() -> Enemy:
	return enemy

func has_overlapping_civil() -> bool:
	return civil != null

func get_overlapping_civil() -> Civil:
	return civil


func _on_area_entered(area: Area2D) -> void:
	player = area.owner as Player
	if player:
		emit_signal("player_entered")
	
	enemy = area.owner as Enemy
	if enemy:
		emit_signal("enemy_entered")
	
	civil = area.owner as Civil
	if civil:
		emit_signal("civil_entered")
	
	emit_signal("entered")

func _on_area_exited(area: Area2D) -> void:
	if area.owner == player:
		player = null
		emit_signal("player_exited")
	
	if area.owner == enemy:
		enemy = null
		emit_signal("enemy_exited")
	
	if area.owner == civil:
		civil = null
		emit_signal("civil_exited")
	
	emit_signal("exited")

func _on_body_entered(body: Node) -> void:
	player = body as Player
	if player:
		emit_signal("player_entered")
	
	enemy = body as Enemy
	if enemy:
		emit_signal("enemy_entered")
	
	civil = body as Civil
	if civil:
		emit_signal("civil_entered")
	
	emit_signal("entered")

func _on_body_exited(body: Node) -> void:
	if body == player:
		player = null
		emit_signal("player_exited")
	
	if body == enemy:
		enemy = null
		emit_signal("enemy_exited")
	
	if body == civil:
		civil = null
		emit_signal("civil_exited")
	
	emit_signal("exited")
