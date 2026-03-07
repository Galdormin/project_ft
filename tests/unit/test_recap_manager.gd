extends GutTest

const DIALOGUE_TEST: String = "res://tests/unit/sample_data/test_recap_manager.dialogue"


func get_dialogue_test() -> DialogueResource:
    return load(DIALOGUE_TEST)

func test_start_end_recap():
    var dialogue = get_dialogue_test()
    
    var line: DialogueLine
    assert_eq(RecapManager.is_active, false)
    assert_eq(len(RecapManager.lines), 0)
    
    line = await dialogue.get_next_dialogue_line("test_start_recap")
    assert_eq(RecapManager.is_active, false)
    assert_eq(len(RecapManager.lines), 0)
    
    line = await dialogue.get_next_dialogue_line(line.next_id)
    assert_eq(RecapManager.is_active, true)
    assert_eq(len(RecapManager.lines), 1)
    
    line = await dialogue.get_next_dialogue_line(line.next_id)
    assert_eq(RecapManager.is_active, true)
    assert_eq(len(RecapManager.lines), 2)
    
    line = await dialogue.get_next_dialogue_line(line.next_id)
    assert_eq(RecapManager.is_active, false)
    assert_eq(len(RecapManager.lines), 0)
    
    line = await dialogue.get_next_dialogue_line(line.next_id)
    assert_eq(RecapManager.is_active, false)
    assert_eq(len(RecapManager.lines), 0)

func test_signals():
    var dialogue = get_dialogue_test()
    
    watch_signals(RecapManager)    
    var line: DialogueLine
    
    line = await dialogue.get_next_dialogue_line("test_start_recap")
    assert_signal_emit_count(RecapManager.line_added, 0)
    assert_signal_emit_count(RecapManager.cleared, 0)
    
    line = await dialogue.get_next_dialogue_line(line.next_id)
    assert_signal_emit_count(RecapManager.line_added, 1)
    assert_signal_emit_count(RecapManager.cleared, 1)
    
    # Test arguments of signals after first emission
    assert_signal_emitted_with_parameters(RecapManager.line_added, [line])
    assert_signal_emitted_with_parameters(RecapManager.cleared, [])
    
    line = await dialogue.get_next_dialogue_line(line.next_id)
    assert_signal_emit_count(RecapManager.line_added, 2)
    assert_signal_emit_count(RecapManager.cleared, 1)
    
    line = await dialogue.get_next_dialogue_line(line.next_id)
    assert_signal_emit_count(RecapManager.line_added, 2)
    assert_signal_emit_count(RecapManager.cleared, 2)
    
    line = await dialogue.get_next_dialogue_line(line.next_id)
    assert_signal_emit_count(RecapManager.line_added, 2)
    assert_signal_emit_count(RecapManager.cleared, 2)
