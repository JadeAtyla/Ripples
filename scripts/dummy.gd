extends Area2D

const SPEED = 100.0
const JUMP_VELOCITY = -250.0

@onready var animate = $AnimatedSprite2D

func _on_body_entered(body: Node2D) -> void:
	animate.play("hurt")

func _on_body_exited(body: Node2D) -> void:
	animate.play("idle")
