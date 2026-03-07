extends Control

const RECAP_MESSAGE_SCENE: PackedScene = preload("res://scenes/dialogue/recap_balloon/recap_message.tscn")

@onready var message_container: VBoxContainer = %MessageContainer
@onready var open_button: TextureButton = %TextureButton

var is_active: bool = true

var _current_recap_message: RecapMessage
var _opened: bool = false
var _open_tween: Tween

func _ready() -> void:
    open_button.pressed.connect(_on_open_button_pressed)
    RecapManager.line_added.connect(_on_recap_line_added)
    RecapManager.cleared.connect(_on_recap_cleared)

func add_message(line: DialogueLine) -> void:
    if not _current_recap_message or _current_recap_message.character.name != line.character:
        _current_recap_message = RECAP_MESSAGE_SCENE.instantiate()
        _current_recap_message.character = CharacterManager.get_character_data(line.character)
        message_container.add_child(_current_recap_message)
    
    _current_recap_message.add_message(line)

func clear_message() -> void:
    for child in message_container.get_children():
        child.queue_free()

func switch_panel() -> void:
    var final_position := 1920
    
    if not _opened:
        final_position -= size.x
    
    if _open_tween:
        _open_tween.kill()
    
    _open_tween = get_tree().create_tween()
    _open_tween.tween_property(self, "position:x", final_position, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
    
    _opened = not _opened
    _open_tween.finished.connect(func(): open_button.flip_h = _opened)


#region Signals

func _on_open_button_pressed() -> void:
    switch_panel()

func _on_recap_line_added(line: DialogueLine) -> void:
    add_message(line)

func _on_recap_cleared() -> void:
    clear_message()

#endregion
