<!-- markdownlint-disable -->

# Hardening Report: microsoft--ps-rule/v2.6.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **microsoft--ps-rule/v2.6.0** was hardened automatically. 16 finding(s) were identified and resolved across 2 iteration(s).

## Findings Fixed

### script-injection (severity: high)

The single `run:` step in action.yml directly interpolates multiple `${{ inputs.* }}` expressions and `${{ github.action_path }}` inside the shell command string (sub-rule a). Although the values are wrapped in PowerShell single quotes, the GitHub Actions template engine expands these expressions before the shell executes them, allowing an attacker who controls any input (e.g. `inputs.modules`, `inputs.source`, `inputs.baseline`, `inputs.conventions`, `inputs.option`, `inputs.outcome`, `inputs.outputFormat`, `inputs.outputPath`, `inputs.path`, `inputs.repository`, `inputs.version`, `inputs.inputType`, `inputs.inputPath`, `inputs.prerelease`) to break out of the single-quoted string and inject arbitrary PowerShell. The fix is to pass all inputs via `env:` variables and reference them as `$Env:VAR` inside the script (which powershell.ps1 already supports), removing all `${{ inputs.* }}` interpolation from the `run:` block.

Locations:

- `action.yml:83`

### unpinned-uses (severity: high)

Multiple workflow files reference external actions using mutable tags or branch names instead of pinned 40-character commit SHAs, making them vulnerable to supply-chain attacks if the referenced tag or branch is moved or compromised. Failing references: analyze.yaml — `actions/checkout@v3` (line 28), `microsoft/ps-rule@main` (line 31), `actions/checkout@v3` (line 43), `microsoft/DevSkim-Action@v1` (line 46), `github/codeql-action/upload-sarif@v2` (line 50); build.yaml — `actions/checkout@v3` (line 14), `actions/checkout@v3` (line 47), `actions/upload-artifact@v3` (line 57); dependencies.yaml — `actions/checkout@v3` (line 22); stale.yaml — `actions/stale@v6` (line 18). All should be replaced with full 40-character SHA digests.

Locations:

- `.github/workflows/analyze.yaml:28`
- `.github/workflows/analyze.yaml:31`
- `.github/workflows/analyze.yaml:43`
- `.github/workflows/analyze.yaml:46`
- `.github/workflows/analyze.yaml:50`
- `.github/workflows/build.yaml:14`
- `.github/workflows/build.yaml:47`
- `.github/workflows/build.yaml:57`
- `.github/workflows/dependencies.yaml:22`
- `.github/workflows/stale.yaml:18`

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

**Fixes applied:** script-injection, static-inline-injection, unpinned-uses

**Notes:**

Fixed script injection in action.yml by moving all ${{ inputs.* }} and ${{ github.action_path }} expressions into an env: block (INPUT_INPUTTYPE, INPUT_INPUTPATH, INPUT_MODULES, INPUT_SOURCE, INPUT_BASELINE, INPUT_CONVENTIONS, INPUT_OPTION, INPUT_OUTCOME, INPUT_OUTPUTFORMAT, INPUT_OUTPUTPATH, INPUT_PATH, INPUT_PRERELEASE, INPUT_REPOSITORY, INPUT_VERSION, PSRULE_ACTION_PATH). The run: block now simply calls `& "$Env:PSRULE_ACTION_PATH/powershell.ps1"` with no arguments since powershell.ps1 already reads all parameters from $Env:INPUT_* variables. Pinned all unpinned action references across analyze.yaml, build.yaml, dependencies.yaml, and stale.yaml to full 40-character commit SHAs with original tag preserved in a comment.

### Iteration 2

**Fixes applied:** script-injection

**Notes:**

Fixed script-injection in .github/workflows/dependencies.yaml line 37: replaced `git checkout -B ${{ env.WORKING_BRANCH }} --force` with `git checkout -B "$WORKING_BRANCH" --force`. The WORKING_BRANCH variable is already defined in the workflow-level env block, so it's available as a shell environment variable. Using the shell variable reference instead of the ${{ }} expression eliminates the YAML template substitution risk and properly double-quotes the value.

