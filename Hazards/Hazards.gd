extends Area2D
 

func _on_SprikeTop_body_entered(body: Node) -> void:
	# body.hurt()	
	get_tree().call_group("Gamestate", "hurt")
