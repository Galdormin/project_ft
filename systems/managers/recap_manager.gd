extends Node
## Autoload used to track the lines to display in the recap.
## The use of a manager is easier to add command in dialogue files

signal line_added(line: DialogueLine)
signal cleared()

var is_active := false
var lines: Array[DialogueLine]

func _ready() -> void:
    DialogueManager.got_dialogue.connect(_on_new_dialogue_line)

func start_recap() -> void:
    clear()
    enable()

func end_recap() -> void:
    clear()
    disable()

func enable() -> void:
    is_active = true

func disable() -> void:
    is_active = false

func add_line(line: DialogueLine) -> void:
    lines.append(line)
    line_added.emit(line)

func clear() -> void:
    lines = []
    cleared.emit()

func _on_new_dialogue_line(line: DialogueLine) -> void:
    if not is_active:
        return
    
    add_line(line)
