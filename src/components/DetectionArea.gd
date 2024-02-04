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
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


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
		player_entered.emit()
	
	enemy = area.owner as Enemy
	if enemy:
		enemy_entered.emit()
	
	civil = area.owner as Civil
	if civil:
		civil_entered.emit()
	
	entered.emit()

func _on_area_exited(area: Area2D) -> void:
	if area.owner == player:
		player = null
		player_exited.emit()
	
	if area.owner == enemy:
		enemy = null
		enemy_exited.emit()
	
	if area.owner == civil:
		civil = null
		civil_exited.emit()
	
	exited.emit()

func _on_body_entered(body: Node) -> void:
	player = body as Player
	if player:
		player_entered.emit()
	
	enemy = body as Enemy
	if enemy:
		enemy_entered.emit()
	
	civil = body as Civil
	if civil:
		civil_entered.emit()
	
	entered.emit()

func _on_body_exited(body: Node) -> void:
	if body == player:
		player = null
		player_exited.emit()
	
	if body == enemy:
		enemy = null
		enemy_exited.emit()
	
	if body == civil:
		civil = null
		civil_exited.emit()
	
	exited.emit()
