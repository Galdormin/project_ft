class_name FlowerDescriptionPanel
extends ColorRect

@export var flower: FlowerData:
    set(p_flower):
        flower = p_flower
        _update_flower()

@onready var flower_image: TextureRect = %FlowerImage
@onready var flower_text: RichTextLabel = %FlowerText
@onready var select_button: Button = %SelectButton

func _ready() -> void:
    select_button.pressed.connect(_on_select_button_pressed)

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("ui_cancel"):
        close()

func _unhandled_input(_event: InputEvent) -> void:
    if visible:
        get_viewport().set_input_as_handled()

## Open the panel with the given flower
func open(p_flower: FlowerData) -> void:
    flower = p_flower
    if StoryManager.is_waiting_for_flower:
        select_button.show()
    else:
        select_button.hide()
    
    show()

## Close the panel
func close() -> void:
    hide()

func _update_flower() -> void:
    flower_image.texture = flower.image
    flower_text.text = flower.description

func _on_select_button_pressed() -> void:
    if StoryManager.is_waiting_for_flower:
        StoryManager.select_flower(flower.name)
    
    close()
