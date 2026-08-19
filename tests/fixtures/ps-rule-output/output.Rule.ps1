# A simple PSRule rule for output format testing
Rule 'Test.OutputPass' -If { $True } {
    $Assert.Pass();
}
