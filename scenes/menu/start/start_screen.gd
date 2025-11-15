extends Container

@onready var version_label: Label = %VersionLabel
@onready var bug_report_scene = preload("res://scenes/menu/bug_report/bug_report.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
    pass


func test_ok() -> int:
    return 0


func _on_quit_button_pressed() -> void:
    Loggie.error("Not Implemented")


func _on_play_button_pressed() -> void:
    Loggie.error("Not Implemented")


func _on_settings_button_pressed() -> void:
    Loggie.error("Not Implemented")


func _on_bug_report_button_pressed() -> void:
    Loggie.info("Send User report to Codecks")

    var bug_report_window = bug_report_scene.instantiate()
    add_child(bug_report_window)
    bug_report_window.show()

    #var report = CodecksUserReport.new(
    #"rt_MYaPsFNHNv8xbNYLM9hr47ey",
    #"This is a sample bug report.",
    #CodecksUserReport.SEVERITY_NONE,
    #"theo.plenet@gmail.com",
    #)
    #
    #add_child(report)
    #report.send()
