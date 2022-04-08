extends KinematicBody2D

class_name Enemy

export(NodePath) var startPath
export(NodePath) var endPath
var nodeStart 
var nodeEnd
export (float) var _speed = 400
var space_between_refs=5
var to_start=true
var active=true
var player=null

func _ready():
	nodeStart = get_node(startPath)
	nodeEnd = get_node(endPath)
	
func _process(_delta):
	if active:
		var velocity = Vector2.ZERO # The player's movement vector.
		var destiny = Vector2.ZERO # The player's movement vector.
		if to_start:
			destiny=nodeStart.global_position
		else:
			destiny=nodeEnd.global_position
		if destiny.x - self.global_position.x  < -space_between_refs:
			velocity.x -= 1
		elif destiny.x - self.global_position.x > space_between_refs:
			velocity.x += 1
			
		if destiny.y - self.global_position.y < -space_between_refs:
			velocity.y -= 1
		elif destiny.y - self.global_position.y > space_between_refs:
			velocity.y += 1
			
		if velocity.length() > 0:
			velocity = velocity.normalized() * _speed
		else:
			to_start= not to_start
		move_and_slide(velocity)
	if player:
		player.damage()

func damage():
	queue_free()

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.damage()
		player=body	


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		player=null
