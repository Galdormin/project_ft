extends Node2D

enum Direction {LEFT, RIGHT}

# Declare constants to be used in Dialogue
const LOOK_LEFT: int = CharacterPortrait.Orientaion.LEFT
const LOOK_RIGHT: int = CharacterPortrait.Orientaion.RIGHT

const INTRO_DIALOGUE = preload("res://dialogue/intro/entrance.dialogue")

@onready var shop_scene: Node2D = $ShopScene
@onready var dialogue_area: DialogueArea = %ShopEntrance.dialogue_area

var switch_tween: Tween

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

func switch_scene(direction: Direction) -> void:
    if switch_tween:
        switch_tween.kill()

    switch_tween = get_tree().create_tween()
    
    var final_position = shop_scene.position.x
    if direction == Direction.LEFT:
        final_position += 1920
    else:
        final_position -= 1920
    
    switch_tween.tween_property(shop_scene, "position:x", final_position, 0.8).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
