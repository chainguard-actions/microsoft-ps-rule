# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# A simple rule that always passes - used for inputPath testing
Rule 'Test.InputPath.Pass' -Tag @{ release = 'GA' } {
    $Assert.Pass();
}
