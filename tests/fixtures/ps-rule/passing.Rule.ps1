# A simple PSRule rule that always passes
Rule 'Test.AlwaysPass' -If { $True } {
    $Assert.Pass();
}
