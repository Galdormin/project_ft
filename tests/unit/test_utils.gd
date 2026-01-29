extends GutTest


func test_assert_subset():
    assert_eq(TestUtils.subset_of([1, 2, 3], [1, 2, 3, 4, 5]), true)
    assert_eq(TestUtils.subset_of(["Titi", "Tata"], ["Titi", "Tata", "Toto"]), true)
    
    assert_eq(TestUtils.subset_of(["Titi", "Tata", "TuTu"], ["Titi", "Tata", "Toto"]), false)

func test_get_files_recursive():
    var files = TestUtils.get_files_recursive("res://tests", "gd")
    assert_eq(len(files), 4)
