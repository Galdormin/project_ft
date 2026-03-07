extends Node2D



func _ready() -> void:
    $Rose.clicked.connect($CanvasLayer.show)

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("ui_cancel"):
        $CanvasLayer.hide()
