extends Node2D

var state = "no apples" # no applees, apples
var player_in_area = false

var apple = preload("res://scene/apple_collectable.tscn")

@export var item: InvItem
var player = null

func _ready():
	if state == "no apples":
		$growth_timer.start()

func _process(delta):
	if state == "no apples":
		$AnimatedSprite2D.play("no apples")
	if state == "apples":
		$AnimatedSprite2D.play("apples")
		if player_in_area:
			if Input.is_action_just_pressed("e"):
				state = "no apples"
				drop_apple()

func _on_pickable_area_body_entered(body):
	if body.has_method("player"):
		player_in_area = true
		player = body

func _on_pickable_area_body_exited(body):
	if body.has_method("player"):
		player_in_area = false

func _on_growth_timer_timeout():
	if state == "no apples":
		state = "apples"

func drop_apple():
	await get_tree().create_timer(0.0).timeout
	var apple_instance = apple.instantiate()
	apple_instance.rotation = rotation
	apple_instance.global_position = $Marker2D.global_position
	get_parent().add_child(apple_instance)
	player.collect(item)
	await get_tree().create_timer(3).timeout # Se espera 3 segundos
	$growth_timer.start()
