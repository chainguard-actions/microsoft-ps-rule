<!-- markdownlint-disable -->

# Hardening Report: microsoft--ps-rule/v2.8.1

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **microsoft--ps-rule/v2.8.1** was hardened automatically. 23 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### script-injection (severity: high)

Sub-rule (a): The composite action's single `run:` step directly interpolates multiple `${{ ... }}` expressions into a PowerShell command string. This includes `${{ github.action_path }}` and all 14 `${{ inputs.* }}` values (inputType, inputPath, modules, source, baseline, conventions, option, outcome, outputFormat, outputPath, path, prerelease, repository, summary, version). An attacker who controls any of these inputs (e.g. via a calling workflow) can inject arbitrary PowerShell commands. The offending line is: `${{ github.action_path }}/powershell.ps1 -InputType '${{ inputs.inputType }}' ...`

Locations:

- `action.yml:79`

### script-injection (severity: high)

Sub-rule (a): The 'Get working branch' step directly interpolates `${{ env.WORKING_BRANCH }}` into a bash `run:` block: `git checkout -B ${{ env.WORKING_BRANCH }} --force`. The `env.WORKING_BRANCH` value flows through YAML template substitution before the shell sees it, allowing injection of shell metacharacters.

Locations:

- `.github/workflows/dependencies.yaml:33`

### script-injection (severity: high)

Sub-rule (a): The 'Push release branch' step directly interpolates `${{ env.RELEASE_BRANCH }}` and `${{ env.LATEST_BRANCH }}` into a PowerShell `run:` block: `$latest = '${{ env.RELEASE_BRANCH }}' -eq '${{ env.LATEST_BRANCH }}'; Update-Branch -Remote origin -Major ${{ env.RELEASE_BRANCH }} -Latest:$latest;`. These expressions are substituted before the shell parses the script, enabling injection.

Locations:

- `.github/workflows/release.yaml:47`

### unpinned-uses (severity: high)

All `uses:` references in this workflow use mutable tag or branch refs instead of immutable 40-character SHA commit hashes, making the workflow vulnerable to supply-chain attacks if the referenced action is compromised or the tag is moved. Unpinned references: `actions/checkout@v3`, `microsoft/ps-rule@main`, `microsoft/DevSkim-Action@v1`, `github/codeql-action/upload-sarif@v2`.

Locations:

- `.github/workflows/analyze.yaml:24`
- `.github/workflows/analyze.yaml:28`
- `.github/workflows/analyze.yaml:38`
- `.github/workflows/analyze.yaml:43`
- `.github/workflows/analyze.yaml:47`

### unpinned-uses (severity: high)

All `uses:` references in this workflow use mutable tag refs instead of immutable 40-character SHA commit hashes. Unpinned references: `actions/checkout@v3` (×2), `actions/upload-artifact@v3`.

Locations:

- `.github/workflows/build.yaml:15`
- `.github/workflows/build.yaml:50`
- `.github/workflows/build.yaml:60`

### unpinned-uses (severity: high)

The `uses:` reference in this workflow uses a mutable tag ref instead of an immutable 40-character SHA commit hash. Unpinned reference: `actions/checkout@v3`.

Locations:

- `.github/workflows/dependencies.yaml:22`

### unpinned-uses (severity: high)

The `uses:` reference in this workflow uses a mutable tag ref instead of an immutable 40-character SHA commit hash. Unpinned reference: `actions/checkout@v3`.

Locations:

- `.github/workflows/release.yaml:33`

### unpinned-uses (severity: high)

The `uses:` reference in this workflow uses a mutable tag ref instead of an immutable 40-character SHA commit hash. Unpinned reference: `actions/stale@v8`.

Locations:

- `.github/workflows/stale.yaml:14`

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

Fixed all 24 findings across 6 files:

1. action.yml: Moved all 15 ${{ }} expressions (github.action_path + 14 inputs.*) from the run: block into an env: map. PowerShell script now uses $env:VAR_NAME references.

2. .github/workflows/dependencies.yaml: Pinned actions/checkout@v3 to SHA a37ce9120846195fa4ece8f58b268e6043cb2f26. Fixed script injection by moving ${{ env.WORKING_BRANCH }} to step env: map as WORKING_BRANCH_NAME and referencing it as "$WORKING_BRANCH_NAME" in bash.

3. .github/workflows/release.yaml: Pinned actions/checkout@v3 to SHA a37ce9120846195fa4ece8f58b268e6043cb2f26. Fixed script injection by moving ${{ env.RELEASE_BRANCH }} and ${{ env.LATEST_BRANCH }} to step env: map and referencing via $env:RELEASE_BRANCH_NAME and $env:LATEST_BRANCH_NAME in PowerShell.

4. .github/workflows/analyze.yaml: Pinned actions/checkout@v3 (×2), microsoft/ps-rule@main, microsoft/DevSkim-Action@v1, and github/codeql-action/upload-sarif@v2 to full SHA hashes.

5. .github/workflows/build.yaml: Pinned actions/checkout@v3 (×2) and actions/upload-artifact@v3 to full SHA hashes.

6. .github/workflows/stale.yaml: Pinned actions/stale@v8 to full SHA hash 1160a2240286f5da8ec72b1c0816ce2481aabf84.

