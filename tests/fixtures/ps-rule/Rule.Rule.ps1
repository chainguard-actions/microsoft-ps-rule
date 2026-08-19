# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

# A simple rule that always passes for testing purposes.
Rule 'Test.Always.Pass' -Tag @{ release = 'GA' } {
    $Assert.Pass();
}
