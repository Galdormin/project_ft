extends GutTest


func test_assert_subset():
    assert_eq(TestUtils.subset_of([1, 2, 3], [1, 2, 3, 4, 5]), true)
    assert_eq(TestUtils.subset_of(["Titi", "Tata"], ["Titi", "Tata", "Toto"]), true)
    
    assert_eq(TestUtils.subset_of(["Titi", "Tata", "TuTu"], ["Titi", "Tata", "Toto"]), false)
