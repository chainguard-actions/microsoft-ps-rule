# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# A simple rule that always passes - used for testing
Rule 'Test.Always.Pass' -Tag @{ release = 'GA' } {
    $Assert.Pass();
}
