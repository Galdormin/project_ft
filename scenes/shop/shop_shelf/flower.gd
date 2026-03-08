class_name Flower
extends Area2D

signal pressed

@export var flower_data: FlowerData
@export var flower_sprite: Sprite2D

var _scale_tween: Tween

func _ready() -> void:
    mouse_entered.connect(_on_mouse_entered)
    mouse_exited.connect(_on_mouse_exited)
    input_event.connect(_on_input_event)

func scale_flower(p_scale: float) -> void:
    if _scale_tween:
        _scale_tween.kill()
    
    _scale_tween = get_tree().create_tween()
    _scale_tween.tween_property(flower_sprite, "scale", p_scale * Vector2.ONE, 0.4).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)

func _on_mouse_entered() -> void:
    scale_flower(0.9)

func _on_mouse_exited() -> void:
    scale_flower(0.8)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        pressed.emit()
