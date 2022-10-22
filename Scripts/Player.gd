extends KinematicBody2D
export var _speed = 350
export var _fire_speed = 1000
var hability = null
var heart = 3
var Bullet = preload("res://Scenes/Demo/Bullet.tscn")
var bullet = null
var fire_time = 0
var invulnerable_time = 0
export var max_shoots_per_second = 3.8


func _ready():
	fire_time = OS.get_system_time_msecs()


func _process(_delta):
	var velocity = Vector2.ZERO  # The player's movement vector.
	if Input.is_action_pressed("ui_close"):
		get_tree().quit()

	if Input.is_action_pressed("ui_right"):
		velocity.x += 1

	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1

	if Input.is_action_pressed("ui_down"):
		velocity.y += 1

	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		if velocity.y < 0:
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("Up")
		elif velocity.y > 0:
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("Down")
		elif velocity.x < 0:
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("Left")
		elif velocity.x > 0:
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("Left")
		velocity = velocity.normalized() * _speed
		velocity = move_and_slide(velocity)
	else:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("default")

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
			&& (OS.get_system_time_msecs() - fire_time) > 1000 / max_shoots_per_second
		):
			fire_time = OS.get_system_time_msecs()
			if hability == "disparo":
				fire(direction)


func damage():
	if OS.get_system_time_msecs() > invulnerable_time:
		heart -= 1
		if heart <= 0:
			get_tree().quit()
		else:
			invulnerable_time = OS.get_system_time_msecs() + 1000
			$hearts.play(str(heart))


func fire(direction: Vector2):
	bullet = Bullet.instance()

	if (direction.y == 1 || direction.y == -1) && direction.x == 0:
		bullet.init("vertical")

	direction = direction.normalized() * _fire_speed

	bullet.shoot = true
	bullet.position = get_global_position()
	bullet.apply_impulse(Vector2(), direction)
	get_tree().get_root().add_child(bullet)
