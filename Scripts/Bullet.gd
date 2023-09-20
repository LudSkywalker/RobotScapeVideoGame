extends RigidBody2D
@export var shoot = false


func init(animation):
	$AnimatedSprite2D.play(animation)


func _on_Area2D_body_entered(body):
	if body.is_in_group("player") && !shoot:
		body.hability = "disparo"
		self.queue_free()
	elif body.is_in_group("enemy"):
		body.damage()
		self.queue_free()


func _on_LifeTime_timeout():
	if shoot:
		queue_free()
