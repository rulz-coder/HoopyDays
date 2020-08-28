extends KinematicBody2D


var motion = Vector2(0,0)

const SPEED = 1500
const GRAVITY = 150
const UP = Vector2(0, -1)
const JUMP_SPEED = 3500
const WORLD_LIMIT = 7000
const BOOST_MULTIPLIER = 0.7
signal animate


func _physics_process(_delta: float) -> void:

	apply_gravity()
	jump()
	move()
	animate()
	move_and_slide(motion, UP)


func apply_gravity():
	if motion.y > WORLD_LIMIT:
		get_tree().call_group("Gamestate", "end_game")
	if is_on_floor():
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 0
	else:
		motion.y += GRAVITY


func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		motion.y -= JUMP_SPEED
		$jumpSFX.play()


func move():
	if Input.is_action_pressed("left") and not Input.is_action_just_pressed("right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = SPEED
	else:
		motion.x = 0 		


func animate():
	emit_signal("animate", motion)
	if motion.y < 0:
		$PlayerAnimation.play("jump")
	elif motion.x >+ 0:
		$PlayerAnimation.play("walk")
		$PlayerAnimation.flip_h = false
	elif motion.x <- 0:
		$PlayerAnimation.play("walk")
		$PlayerAnimation.flip_h = true
	else:
		$PlayerAnimation.play("idle")


func hurt():
	motion.y -= 1
	yield(get_tree(), "idle_frame")
	motion.y -= JUMP_SPEED
	$painSFX.play()
	# if lives < 0:
	# 	end_game()


func boost():
	motion.y -= 1
	yield(get_tree(), "idle_frame")
	motion.y -= JUMP_SPEED * BOOST_MULTIPLIER
