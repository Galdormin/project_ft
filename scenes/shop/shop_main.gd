extends Node2D

# Declare constants to be used in Dialogue
const LOOK_LEFT: int = CharacterPortrait.Orientaion.LEFT
const LOOK_RIGHT: int = CharacterPortrait.Orientaion.RIGHT

const dialogue = preload("res://dialogue/intro/entrance.dialogue")

@onready var dialogue_area: DialogueArea = $ShopEntrance.dialogue_area

func _ready() -> void:
    dialogue_area.start(dialogue, "start", [])


func add_character(character: String, pos: String, orientation: int, mood: String) -> void:
    var mood_val = CharacterPortrait.as_mood(mood) 
    dialogue_area.add_character(character, pos, orientation, mood_val)
