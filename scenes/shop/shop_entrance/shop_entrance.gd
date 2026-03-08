extends Node2D


@onready var dialogue_area: DialogueArea = $DialogueArea
@onready var flower_button: Button = $Button


func _process(_delta: float) -> void:
    if StoryManager.is_waiting_for_flower:
        flower_button.show()
        if StoryManager.selected_flower == "":
            flower_button.disabled = true
            flower_button.text = "Choisissez une fleur"
        else:
            flower_button.disabled = false
            flower_button.text = "Donner une %s" % StoryManager.selected_flower
    else:
        flower_button.hide()

func wait_flower() -> void:
    StoryManager.is_waiting_for_flower = true
    dialogue_area._talking_character.reset_dialogue_line()

    await flower_button.pressed
    StoryManager.give_flower()
