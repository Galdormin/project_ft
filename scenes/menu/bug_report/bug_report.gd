extends Window

@onready var report_type_option: OptionButton = %ReportTypeOption
@onready var summary_edit: LineEdit = %SummaryEdit
@onready var detail_edit: TextEdit = %DetailEdit
@onready var email_edit: LineEdit = %EmailEdit


func generate_report() -> CodecksUserReport:
    var summary = summary_edit.text
    var detail = detail_edit.text
    var report_type = report_type_option.text.to_lower()
    var email = email_edit.text

    var report = CodecksUserReport.new(
        "rt_MYaPsFNHNv8xbNYLM9hr47ey",
        "%s\n\n#%s\n\n%s" % [summary, report_type, detail],
        CodecksUserReport.SEVERITY_NONE,
        email,
    )
    return report


func send_report() -> void:
    var report = generate_report()
    add_child(report)
    report.card_created.connect(_on_card_created)
    report.send()

    hide() # we close when we the card is created


func close() -> void:
    queue_free()


func _on_close_requested() -> void:
    queue_free()


func _on_send_button_pressed() -> void:
    send_report()


func _on_card_created(card_id: int) -> void:
    Loggie.info("Report created with id %s" % card_id)
    close()
