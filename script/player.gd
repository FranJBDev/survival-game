extends CharacterBody2D
# https://www.youtube.com/playlist?list=PL3cGrGHvkwn2NOT1LSwf5d2XZmlc5Bjsn

var speed = 100

var player_state

@export var inv: Inv

func _physics_process(delta):
	# Toma los valores de las teclas dadas para darle valores a un vector 2D (x, y)
	var direction = Input.get_vector("left", "right", "up", "down") 

	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"
		
	velocity = direction * speed
	move_and_slide()
	
	play_anim(direction)
	
func play_anim(dir):
	if player_state == "idle":
		$AnimatedSprite2D.play("idle")
	if player_state == "walking": #Animacion en 8 direcciones
		if dir.y == -1:
			$AnimatedSprite2D.play("n-walk")
		if dir.y == 1:
			$AnimatedSprite2D.play("s-walk")
		if dir.x == -1:
			$AnimatedSprite2D.play("w-walk")
		if dir.x == 1:
			$AnimatedSprite2D.play("e-walk")
			
		if dir.x > 0.5 and dir.y < -0.5:
			$AnimatedSprite2D.play("ne-walk")
		if dir.x < -0.5 and dir.y < -0.5:
			$AnimatedSprite2D.play("nw-walk")
		if dir.x > 0.5 and dir.y > 0.5:
			$AnimatedSprite2D.play("se-walk")
		if dir.x < -0.5 and dir.y > 0.5:
			$AnimatedSprite2D.play("sw-walk")

func player():
	pass

func collect(item):
	inv.insert(item)
