extends Node2D

signal clicked

@onready var flower: Sprite2D = $RoseBouquet

var _scale_tween: Tween

func _ready() -> void:
    $Area2D.mouse_entered.connect(_on_mouse_entered)
    $Area2D.mouse_exited.connect(_on_mouse_exited)
    $Area2D.input_event.connect(_on_input_event)

func scale_flower(p_scale: float) -> void:
    if _scale_tween:
        _scale_tween.kill()
    
    _scale_tween = get_tree().create_tween()
    _scale_tween.tween_property(flower, "scale", p_scale * Vector2.ONE, 0.4).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)

func _on_mouse_entered() -> void:
    scale_flower(0.9)

func _on_mouse_exited() -> void:
    scale_flower(0.8)


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        clicked.emit()
