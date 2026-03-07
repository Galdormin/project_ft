extends Node2D

enum Direction {LEFT, RIGHT}

# Declare constants to be used in Dialogue
const LOOK_LEFT: int = CharacterPortrait.Orientaion.LEFT
const LOOK_RIGHT: int = CharacterPortrait.Orientaion.RIGHT

const INTRO_DIALOGUE = preload("res://dialogue/intro/entrance.dialogue")

@onready var shop_scene: Node2D = $ShopScene
@onready var dialogue_area: DialogueArea = %ShopEntrance.dialogue_area

var switch_tween: Tween
var _current_screen: int = 0

func _ready() -> void:
    dialogue_area.start(INTRO_DIALOGUE, "start", [])

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("switch_left"):
        switch_scene(Direction.LEFT)
    elif Input.is_action_just_pressed("switch_right"):
        switch_scene(Direction.RIGHT)

func add_character(character: String, pos: String, orientation: int, mood: String) -> void:
    var mood_val = CharacterPortrait.as_mood(mood) 
    dialogue_area.add_character(character, pos, orientation, mood_val)

func remove_character(character_name: String) -> void:
    dialogue_area.remove_character(character_name)

func switch_scene(direction: Direction) -> void:
    if switch_tween:
        switch_tween.kill()

    switch_tween = get_tree().create_tween()
    
    if direction == Direction.LEFT:
        _current_screen = max(_current_screen - 1, 0)
    else:
        _current_screen = min(_current_screen + 1, 1)
    
    switch_tween.tween_property(shop_scene, "position:x", -1920 * _current_screen, 0.8).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
