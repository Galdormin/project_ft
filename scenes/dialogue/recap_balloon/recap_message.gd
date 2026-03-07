class_name RecapMessage
extends HBoxContainer

@export var character: CharacterPortrait

@onready var portrait: TextureRect = %Portrait
@onready var name_label: Label = %NameLabel
@onready var message_container: VBoxContainer = %MessageContainer

func _ready() -> void:
    if character == null:
        Loggie.error("Character of RecapMessage is null.")
        return
    
    name_label.text = character.name
    portrait.texture = character.recap_portrait
    
    if CharacterManager.is_main_character(character.name):
        move_child($PortraitContainer, -1)
        name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
    
    clear_messages()

func add_message(line: DialogueLine) -> void:
    if line.character != character.name:
        Loggie.error("")
    
    var text = RichTextLabel.new()
    text.bbcode_enabled = true
    text.fit_content = true
    text.text = line.text
    
    var margin_container = MarginContainer.new()
    margin_container.add_child(text)
    
    var panel_container = PanelContainer.new()
    panel_container.add_child(margin_container)
    
    message_container.add_child(panel_container)

func clear_messages() -> void:
    for child in message_container.get_children():
        child.queue_free()
