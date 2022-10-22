extends Node2D
var used = false


func _process(_delta):
	if used:
		if (
			!is_instance_valid($EnemyFinal)
			&& !is_instance_valid($EnemyFinal2)
			&& !is_instance_valid($EnemyFinal3)
			&& !is_instance_valid($EnemyFinal4)
			&& !is_instance_valid($EnemyFinal5)
		):
			OS.alert("¡Felicidades!, has ganado\nHas demostrado tu inteligencia y valentia")
			get_tree().quit()


func _on_Area2D_body_exited(body):
	if body.is_in_group("player") && !used:
		used = true
		$EnemyFinal.active = true
		$EnemyFinal2.active = true
		$EnemyFinal3.active = true
		$EnemyFinal4.active = true
		$EnemyFinal5.active = true
