@tool
class_name Character
extends Node2D

@export var character_data: CharacterData:
    set(p_character_data):
        if p_character_data != character_data:
            character_data = p_character_data
            _update_sprite()
@export var mood: CharacterPortrait.Mood:
    set(p_mood):
        if p_mood != mood:
            mood = p_mood
            _update_sprite()
@export var orientation: CharacterPortrait.Orientaion:
    set(p_orientation):
        if p_orientation != orientation:
            orientation = p_orientation
            _update_sprite()
@export var height: float = 300:
    set(p_height):
        if p_height != height:
            height = p_height
            _update_sprite()

@onready var sprite: Sprite2D = %CharacterPortrait
@onready var dialoge_balloon: Control = %DialogueBalloon
@onready var dialogue_label: DialogueLabel = %DialogueLabel

func _ready() -> void:
    _update_sprite()
    reset_dialogue_line()

func _process(_delta: float) -> void:
    pass

func reset_dialogue_line() -> void:
    dialoge_balloon.hide()

func set_dialogue_line(dialogue_line: DialogueLine) -> void:
    # Set Emotion
    for tag in dialogue_line.tags:
        if CharacterPortrait.is_mood(tag):
            mood = CharacterPortrait.as_mood(tag)
            break
    
     # Set line
    if dialogue_line:
        dialoge_balloon.show()
        dialogue_label.dialogue_line = dialogue_line
        dialogue_label.type_out()
    else:
        reset_dialogue_line()

func _update_sprite() -> void:
    if not is_node_ready():
        return
    
    if not character_data:
        Loggie.warn("Try to _update_sprite with no CharacterData.")
        return
    
    if mood in character_data.portrait.sprites:
        sprite.texture = character_data.portrait.sprites[mood]
    
    # Setup Scale
    sprite.scale = Vector2.ONE * (height / sprite.texture.get_height())
    position.y = - height / 2
    
    # Setup Orientation
    if orientation != character_data.portrait.default_orientation:
        sprite.scale.x *= -1
