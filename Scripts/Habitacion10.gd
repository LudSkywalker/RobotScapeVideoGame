extends Node2D
var used = false


func _process(_delta):
	if used:
		if (
			!has_node("EnemyFinal")
			&& !has_node("EnemyFinal1")
			&& !has_node("EnemyFinal2")
			&& !has_node("EnemyFinal3")
			&& !has_node("EnemyFinal4")
		):
			OS.alert("¡Felicidades!, has ganado\nHas demostrado tu inteligencia y valentia")
			get_tree().quit()
			used = false


func _on_Area2D_body_exited(body):
	if body.is_in_group("player") && !used:
		used = true
		$EnemyFinal.active = true
		$EnemyFinal2.active = true
		$EnemyFinal3.active = true
		$EnemyFinal4.active = true
		$EnemyFinal5.active = true
