extends Node

const CHARACTER_FOLDER: String = "res://dialogue/characters"
const CHARACTER_SCENE: PackedScene = preload("res://scenes/character/character.tscn")

const MAIN_CHARACTER: String = "Robin"

var _characters: Dictionary[String, CharacterData] = {}

func _ready() -> void:
    _load_characters()

func _process(_delta: float) -> void:
    pass

func all_characters() -> Array[String]:
    return _characters.keys()

func is_main_character(character_name: String) -> bool:
    return character_name == MAIN_CHARACTER

func get_character_data(character_name: String) -> CharacterData:
    if character_name not in _characters:
        Loggie.error("Portrait queried with unkown character name: " + character_name)
        return null
    
    return _characters[character_name]

func get_character_node(character_name: String) -> Character:
    if character_name not in _characters:
        Loggie.error("Character queried with unkown character name: " + character_name)
        return null
    
    var character_node: Character = CHARACTER_SCENE.instantiate()
    character_node.character_data = get_character_data(character_name)
    return character_node

func _load_characters() -> void:
    var dir := DirAccess.open(CHARACTER_FOLDER)
    
    if dir == null:
        Loggie.error("Cannot open folder: " + CHARACTER_FOLDER)
        return
    
    for file in dir.get_files():
        if not file.ends_with(".tres"):
            Loggie.warn("Non resource file found in Character folder: " + file)
            continue
        
        var res = load(CHARACTER_FOLDER + "/" + file)
        if res is not CharacterData:
            Loggie.warn("Non CharacterPortrait resource file found in Character folder: " + file)
            continue
        
        _characters[res.name] = res
