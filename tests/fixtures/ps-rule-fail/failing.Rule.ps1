# A simple PSRule rule that always fails
Rule 'Test.AlwaysFail' -If { $True } {
    $Assert.Fail('This rule always fails.');
}
