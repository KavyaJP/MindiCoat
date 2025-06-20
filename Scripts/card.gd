extends Control

@export var suit: String
@export var rank: String
@export var value: int

func set_card_data(suit_name, rank_name, val, texture):
	suit = suit_name
	rank = rank_name
	value = val
	$TextureRect.texture = texture

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		var play_area = get_tree().get_root().get_node("Game/PlayArea")
		get_parent().remove_child(self)
		play_area.add_child(self)

		# If PlayArea is Control, use anchors/margins for positioning
		if self is Control:
			self.anchor_left = 0.5
			self.anchor_top = 0.5
			self.margin_left = -self.rect_size.x / 2
			self.margin_top = -self.rect_size.y / 2
		else:
			self.rect_position = Vector2(500, 300)
