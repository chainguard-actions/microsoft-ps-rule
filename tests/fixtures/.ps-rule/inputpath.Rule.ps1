# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# A rule that checks a property exists in structured input
Rule 'Test.InputPath.HasName' {
    $Assert.HasField($TargetObject, 'name')
}
