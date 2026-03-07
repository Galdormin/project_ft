extends Control

var is_active: bool = true

var _opened: bool = false

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var message_container: VBoxContainer = %MessageContainer
@onready var open_button: TextureButton = %TextureButton

func _ready() -> void:
    open_button.pressed.connect(_on_open_button_pressed)
    RecapManager.line_added.connect(_on_recap_line_added)
    RecapManager.cleared.connect(_on_recap_cleared)

func add_message(character: String, text: String) -> void:
    var bbcode_text = "[color=red]%s[/color] --- [indent]%s[/indent]" % [character, text]

    var message = RichTextLabel.new()
    message.bbcode_enabled = true
    message.fit_content = true
    message.text = bbcode_text

    message_container.add_child(message)

func clear_message() -> void:
    for child in message_container.get_children():
        child.queue_free()

func switch_panel() -> void:
    if _opened:
        animation_player.play("close_panel")
    else:
        animation_player.play("open_panel")

    _opened = not _opened


#region Signals

func _on_open_button_pressed() -> void:
    switch_panel()

func _on_recap_line_added(line: DialogueLine) -> void:
    add_message(line.character, line.text)

func _on_recap_cleared() -> void:
    clear_message()

#endregion
