<!-- markdownlint-disable -->

# Hardening Report: microsoft--ps-rule/v2.8.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **microsoft--ps-rule/v2.8.0** was hardened automatically. 19 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### script-injection (severity: high)

Sub-rule (a): The composite action's single `run:` step directly interpolates `${{ github.action_path }}` and all 16 `${{ inputs.* }}` expressions (inputType, inputPath, modules, source, baseline, conventions, option, outcome, outputFormat, outputPath, path, prerelease, repository, summary, version) into a PowerShell command string. Although inputs are wrapped in single quotes, the `${{ ... }}` template substitution happens before the shell sees the string — an attacker-controlled input containing a single quote can break out of the quoted argument and inject arbitrary PowerShell commands. Example offending line: `${{ github.action_path }}/powershell.ps1 -InputType '${{ inputs.inputType }}' ...`

Locations:

- `action.yml:87`

### script-injection (severity: high)

Sub-rule (a): The `Push release branch` step directly interpolates `${{ env.RELEASE_BRANCH }}` and `${{ env.LATEST_BRANCH }}` into a PowerShell `run:` block. `RELEASE_BRANCH` is derived from `${{ inputs.major || 'v2' }}`, a `workflow_dispatch` input, making it attacker-controllable. Offending lines: `$latest = '${{ env.RELEASE_BRANCH }}' -eq '${{ env.LATEST_BRANCH }}';` and `Update-Branch -Remote origin -Major ${{ env.RELEASE_BRANCH }} -Latest:$latest;`

Locations:

- `.github/workflows/release.yaml:51`

### script-injection (severity: high)

Sub-rule (a): The `Get working branch` step directly interpolates `${{ env.WORKING_BRANCH }}` into a shell `run:` block: `git checkout -B ${{ env.WORKING_BRANCH }} --force`. The `WORKING_BRANCH` env var is set from a hardcoded string in this file, but the `${{ env.* }}` expression is still expanded by the YAML template engine before the shell sees it, constituting a script-injection pattern.

Locations:

- `.github/workflows/dependencies.yaml:36`

### unpinned-uses (severity: high)

Multiple workflow files reference external actions using mutable tags or branch names instead of pinned 40-character commit SHAs, making the workflows vulnerable to supply-chain attacks if the referenced tags are moved or the branches are updated maliciously.

analyze.yaml:
  - `actions/checkout@v3` (line 27)
  - `microsoft/ps-rule@main` (line 30)
  - `actions/checkout@v3` (line 40)
  - `microsoft/DevSkim-Action@v1` (line 43)
  - `github/codeql-action/upload-sarif@v2` (line 47)

build.yaml:
  - `actions/checkout@v3` (line 14)
  - `actions/checkout@v3` (line 57)
  - `actions/upload-artifact@v3` (line 67)

dependencies.yaml:
  - `actions/checkout@v3` (line 23)

release.yaml:
  - `actions/checkout@v3` (line 37)

stale.yaml:
  - `actions/stale@v8` (line 18)

Locations:

- `.github/workflows/analyze.yaml:27`
- `.github/workflows/analyze.yaml:30`
- `.github/workflows/analyze.yaml:40`
- `.github/workflows/analyze.yaml:43`
- `.github/workflows/analyze.yaml:47`
- `.github/workflows/build.yaml:14`
- `.github/workflows/build.yaml:57`
- `.github/workflows/build.yaml:67`
- `.github/workflows/dependencies.yaml:23`
- `.github/workflows/release.yaml:37`
- `.github/workflows/stale.yaml:18`

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

**Fixes applied:** script-injection, static-inline-injection, unpinned-uses

**Notes:**

Fixed all findings across 5 files:

1. action.yml: Moved all 16 inputs.* expressions and github.action_path into the step's env: block (INPUT_INPUTTYPE, INPUT_INPUTPATH, INPUT_MODULES, INPUT_SOURCE, INPUT_BASELINE, INPUT_CONVENTIONS, INPUT_OPTION, INPUT_OUTCOME, INPUT_OUTPUTFORMAT, INPUT_OUTPUTPATH, INPUT_PATH, INPUT_PRERELEASE, INPUT_REPOSITORY, INPUT_SUMMARY, INPUT_VERSION, ACTION_PATH). The run: script now uses $env:VAR_NAME PowerShell syntax.

2. release.yaml: Pinned actions/checkout@v3 to SHA a37ce9120846195fa4ece8f58b268e6043cb2f26. Fixed script injection in 'Push release branch' step by moving RELEASE_BRANCH and LATEST_BRANCH into step-level env vars (STEP_RELEASE_BRANCH, STEP_LATEST_BRANCH).

3. dependencies.yaml: Pinned actions/checkout@v3 to SHA a37ce9120846195fa4ece8f58b268e6043cb2f26. Fixed script injection in 'Get working branch' step by moving WORKING_BRANCH into step-level env var STEP_WORKING_BRANCH.

4. analyze.yaml: Pinned actions/checkout@v3, microsoft/ps-rule@main, microsoft/DevSkim-Action@v1, and github/codeql-action/upload-sarif@v2 to their full commit SHAs.

5. build.yaml: Pinned both instances of actions/checkout@v3 and actions/upload-artifact@v3 to their full commit SHAs.

6. stale.yaml: Pinned actions/stale@v8 to its full commit SHA.

All original tag names preserved as inline comments.

