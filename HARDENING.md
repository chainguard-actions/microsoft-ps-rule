<!-- markdownlint-disable -->

# Hardening Report: microsoft--ps-rule/v2.8.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `1`

Action **microsoft--ps-rule/v2.8.0** was hardened automatically. 16 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### script-injection (severity: high)

The `run:` block in `action.yml` directly interpolates multiple GitHub Actions expressions into a PowerShell shell command string, violating sub-rule (a). Specifically, `${{ github.action_path }}` is used to form the script path, and all 15 `inputs.*` values (`${{ inputs.inputType }}`, `${{ inputs.inputPath }}`, `${{ inputs.modules }}`, `${{ inputs.source }}`, `${{ inputs.baseline }}`, `${{ inputs.conventions }}`, `${{ inputs.option }}`, `${{ inputs.outcome }}`, `${{ inputs.outputFormat }}`, `${{ inputs.outputPath }}`, `${{ inputs.path }}`, `${{ inputs.prerelease }}`, `${{ inputs.repository }}`, `${{ inputs.summary }}`, `${{ inputs.version }}`) are interpolated directly into the command. These values are substituted by the YAML template engine before the shell processes the string, so an attacker who controls any input (e.g., via workflow_dispatch or a calling workflow) can inject PowerShell metacharacters — for example, a single-quote in `inputs.inputType` breaks out of the surrounding `'...'` quoting and allows arbitrary command execution. The fix is to pass all inputs via `env:` variables and reference them as `$env:INPUT_*` inside the script (which powershell.ps1 already supports natively), removing all `${{ ... }}` expressions from the `run:` block entirely.

Locations:

- `action.yml:84`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.inputType }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:93`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.inputPath }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:93`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.modules }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:93`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.source }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:93`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.baseline }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:93`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.conventions }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:93`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.option }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:93`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.outcome }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:93`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.outputFormat }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:93`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.outputPath }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:93`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.path }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:93`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.prerelease }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:93`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.repository }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:93`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.summary }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:93`

### static-inline-injection (severity: high)

shell injection: expression "${{ inputs.version }}" appears directly in run: block of step "Analysis"; move to env: map

Locations:

- `action.yml:93`

## Iteration Notes

### Iteration 1

**Fixes applied:** script-injection, static-inline-injection

**Notes:**

Fixed all 16 script injection findings in action.yml. Moved all ${{ }} expressions out of the run: block and into an env: block: github.action_path → INPUT_ACTION_PATH, and all 15 inputs.* values → their corresponding INPUT_* env vars. The run: block now simply calls `& "$env:INPUT_ACTION_PATH/powershell.ps1"` with no inline expressions. This is safe because powershell.ps1 already reads all parameters from $Env:INPUT_* environment variables as defaults (e.g., `[String]$InputType = $Env:INPUT_INPUTTYPE`), so no CLI arguments are needed.

