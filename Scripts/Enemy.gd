extends CharacterBody2D

class_name Enemy

@export var nodeStart:Node
@export var nodeEnd:Node

@export var _speed: float = 600.0
var space_between_refs = 40
var to_start = true
var active = true
var player = null


func _process(_delta):
	if active:
		var enemy_velocity = Vector2.ZERO  # The player's movement vector.
		var destiny = Vector2.ZERO  # The player's movement vector.
		if to_start:
			destiny = nodeStart.global_position
		else:
			destiny = nodeEnd.global_position
		if destiny.x - self.global_position.x < -space_between_refs:
			enemy_velocity.x -= 1
		elif destiny.x - self.global_position.x > space_between_refs:
			enemy_velocity.x += 1

		if destiny.y - self.global_position.y < -space_between_refs:
			enemy_velocity.y -= 1
		elif destiny.y - self.global_position.y > space_between_refs:
			enemy_velocity.y += 1

		if enemy_velocity.length() > 0:
			enemy_velocity = enemy_velocity.normalized() * _speed
		else:
			to_start = not to_start
		set_velocity(enemy_velocity)
		move_and_slide()
		enemy_velocity = velocity

	if player:
		player.damage()


func damage():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.damage()
		player = body


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		player = null
