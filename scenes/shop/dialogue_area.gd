class_name DialogueArea
extends Node2D

@export var dialogue_resource: DialogueResource
@export var slots: Dictionary[String, Marker2D]


var _characters: Dictionary[String, Character] = {}
var _talking_character: Character
var _dialogue_line: DialogueLine:
    set(p_line):
        _dialogue_line = p_line
        _apply_dialogue_line()

func _ready() -> void:
    pass

func _unhandled_input(event: InputEvent) -> void:
    if not _dialogue_line:
        return
    
    if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
        _next(_dialogue_line.next_id)
    elif event.is_action_pressed("ui_accept") and get_viewport().gui_get_focus_owner() == self:
        _next(_dialogue_line.next_id)

func start(resource: DialogueResource, title: String, _extra_game_states: Array) -> void:
    dialogue_resource = resource
    _dialogue_line = await dialogue_resource.get_next_dialogue_line(title)
    show()

func add_character(character_name: String, pos: String, orientation: CharacterPortrait.Orientaion, mood: CharacterPortrait.Mood) -> void:
    Loggie.debug("Add character %s at position %s" % [character_name, pos])
    
    if character_name in _characters:
        Loggie.warn("Try to add Character %s but already in scene." % character_name)
        return
    
    # Create Charater
    var character_node := CharacterManager.get_character_node(character_name)
    if not character_node:
        Loggie.error("Try to add character %s that is not loaded by CharacterManager." % character_name)
        return
    
    character_node.orientation = orientation
    character_node.mood = mood
    _characters[character_name] = character_node
    
    # Create PathFollow for position
    if pos == "Left":
        character_node.height = 1900
    else:
        character_node.height = 1400
    
    slots[pos].add_child(character_node)

func _next(next_id: String) -> void:
    _dialogue_line = await dialogue_resource.get_next_dialogue_line(next_id)

func _apply_dialogue_line() -> void:
    if not _dialogue_line:
        if _talking_character:
            _talking_character.reset_dialogue_line()
        return
    
    var char_name = _dialogue_line.character
    
    if _talking_character and _talking_character.name != char_name:
        _talking_character.reset_dialogue_line()
    
    if char_name not in _characters:
        Loggie.warn("Dialogue line with unloaded character: " + char_name)
        return
    
    _talking_character = _characters[char_name]
    _talking_character.set_dialogue_line(_dialogue_line)
