extends CharacterBody2D
@export var _speed = 550
@export var _fire_speed = 1500
var hability = null
var heart = 3
var Bullet = preload("res://Scenes/Demo/Bullet.tscn")
var bullet = null
var fire_time = 0
var invulnerable_time = 0
@export var max_shoots_per_second = 3.8


func _ready():
	fire_time = Time.get_ticks_msec()


func _process(_delta):
	var player_velocity = Vector2.ZERO  # The player's movement vector.
	if Input.is_action_pressed("ui_cancel"):
		get_tree().reload_current_scene()

	if Input.is_action_pressed("ui_right"):
		player_velocity.x += 1

	if Input.is_action_pressed("ui_left"):
		player_velocity.x -= 1

	if Input.is_action_pressed("ui_down"):
		player_velocity.y += 1

	if Input.is_action_pressed("ui_up"):
		player_velocity.y -= 1

	if player_velocity.length() > 0:
		if player_velocity.y < 0:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("Up")
		elif player_velocity.y > 0:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("Down")
		elif player_velocity.x < 0:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("Left")
		elif player_velocity.x > 0:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("Left")
		player_velocity = player_velocity.normalized() * _speed
		set_velocity(player_velocity)
		move_and_slide()
		player_velocity = velocity
	else:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("default")

	if hability:
		var direction = Vector2.ZERO
		if Input.is_action_pressed("action_right"):
			direction.x += 1
		if Input.is_action_pressed("action_left"):
			direction.x -= 1
		if Input.is_action_pressed("action_down"):
			direction.y += 1
		if Input.is_action_pressed("action_up"):
			direction.y -= 1
		if (
			direction.length() > 0
			&& (Time.get_ticks_msec() - fire_time) > 1000 / max_shoots_per_second
		):
			fire_time = Time.get_ticks_msec()
			if hability == "disparo":
				fire(direction)


func damage():
	if Time.get_ticks_msec() > invulnerable_time:
		heart -= 1
		if heart <= 0:
			OS.alert("¡Lastima!\nIntentalo nuevamente, no pierdas tu determinación","FIN")
			get_tree().reload_current_scene()
		else:
			invulnerable_time = Time.get_ticks_msec() + 1000
			$hearts.play(str(heart))


func fire(direction: Vector2):
	bullet = Bullet.instantiate()

	if (direction.y == 1 || direction.y == -1) && direction.x == 0:
		bullet.init("vertical")

	direction = direction.normalized() * _fire_speed

	bullet.shoot = true
	bullet.position = get_global_position()
	bullet.apply_impulse(direction, Vector2())
	get_tree().get_root().add_child(bullet)
