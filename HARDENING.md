<!-- markdownlint-disable -->

# Hardening Report: microsoft--ps-rule/v2.6.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `1`

Action **microsoft--ps-rule/v2.6.0** was hardened automatically. 15 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### script-injection (severity: high)

Sub-rule (a): The `run:` block in action.yml directly interpolates multiple `${{ inputs.* }}` and `${{ github.action_path }}` expressions into a PowerShell command string without routing them through environment variables. An attacker controlling any of the inputs (inputType, inputPath, modules, source, baseline, conventions, option, outcome, outputFormat, outputPath, path, prerelease, repository, version) can inject arbitrary PowerShell commands by embedding single-quote escapes or PowerShell metacharacters. The offending line is: `${{ github.action_path }}/powershell.ps1 -InputType '${{ inputs.inputType }}' -InputPath '${{ inputs.inputPath }}' ... -Version '${{ inputs.version }}'`

Locations:

- `action.yml:84`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.inputType }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:88`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.inputPath }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:88`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.modules }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:88`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.source }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:88`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.baseline }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:88`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.conventions }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:88`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.option }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:88`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.outcome }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:88`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.outputFormat }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:88`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.outputPath }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:88`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.path }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:88`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.prerelease }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:88`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.repository }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:88`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.version }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:88`

## Iteration Notes

### Iteration 1

**Fixes applied:** script-injection, static-inline-injection

**Notes:**

Moved all ${{ github.action_path }} and ${{ inputs.* }} expressions from the run: block into an env: block (ACTION_PATH, INPUT_INPUT_TYPE, INPUT_INPUT_PATH, INPUT_MODULES, INPUT_SOURCE, INPUT_BASELINE, INPUT_CONVENTIONS, INPUT_OPTION, INPUT_OUTCOME, INPUT_OUTPUT_FORMAT, INPUT_OUTPUT_PATH, INPUT_PATH, INPUT_PRERELEASE, INPUT_REPOSITORY, INPUT_VERSION). The PowerShell run: block now uses $env:VAR_NAME references instead of direct expression interpolation, eliminating the script injection risk. The script invocation was also changed from bare path interpolation to the PowerShell call operator & with a quoted path string.

