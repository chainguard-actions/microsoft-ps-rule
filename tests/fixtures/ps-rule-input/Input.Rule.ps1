# A simple rule that validates input objects
Rule 'Test.Input.HasName' -Tag @{ test = 'true' } {
    $Assert.HasField($TargetObject, 'metadata.name');
}
