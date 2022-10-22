extends Enemy

var batery = 18


func _ready():
	active = false
	_speed = 210
	nodeStart = get_tree().get_root().get_node("Demo/Player")
	nodeEnd = get_tree().get_root().get_node("Demo/Player")


func damage():
	if active:
		batery -= 1
		if batery <= 0:
			queue_free()
		else:
			if int(batery / 3) > 0:
				$Batery.play(str(int(batery / 3)))
