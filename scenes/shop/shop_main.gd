extends Node2D

const LOOK_LEFT: int = 0
const LOOK_RIGHT: int = 1

const dialogue = preload("res://dialogue/intro/entrance.dialogue")

func _ready() -> void:
    $DialogueArea.start(dialogue, "start", [])


func add_character(character: String, pos: float, orientation: int, emotion: String) -> void:
    var emotion_val = CharacterPortrait.as_emotion(emotion) 
    $DialogueArea.add_character(character, pos, orientation, emotion_val)
