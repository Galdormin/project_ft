class_name DragObject2D
extends AnimatableBody2D

var is_dragged: bool = false


func _ready() -> void:
    input_event.connect(_on_input_event)


func _process(_delta: float) -> void:
    if is_dragged:
        global_position = get_global_mouse_position()


func _input(event: InputEvent) -> void:
    if event.is_action_released("Select", true):
        is_dragged = false


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
    if event.is_action_pressed("Select"):
        is_dragged = true
