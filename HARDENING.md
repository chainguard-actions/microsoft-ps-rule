<!-- markdownlint-disable -->

# Hardening Report: microsoft--ps-rule/v2.9.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **microsoft--ps-rule/v2.9.0** was hardened automatically. 19 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### script-injection (severity: high)

Sub-rule (a): The action.yml composite action's single `run:` step directly interpolates `${{ github.action_path }}` and all 15 `${{ inputs.* }}` expressions (inputType, inputPath, modules, source, baseline, conventions, option, outcome, outputFormat, outputPath, path, prerelease, repository, summary, version) inside a PowerShell shell command. These expressions are expanded by the YAML template engine before the shell processes the command, allowing an attacker-controlled input value to inject arbitrary PowerShell commands. Example offending line: `${{ github.action_path }}/powershell.ps1 -InputType '${{ inputs.inputType }}' ...`

Locations:

- `action.yml:76`

### script-injection (severity: high)

Sub-rule (a): The 'Get working branch' step in dependencies.yaml directly interpolates `${{ env.WORKING_BRANCH }}` inside a `run:` shell command: `git checkout -B ${{ env.WORKING_BRANCH }} --force`. Any ${{ }} expression in a run: block is a script-injection risk as it is expanded by the YAML template engine before the shell sees it.

Locations:

- `.github/workflows/dependencies.yaml:35`

### script-injection (severity: high)

Sub-rule (a): The 'Push release branch' step in release.yaml directly interpolates `${{ env.RELEASE_BRANCH }}` and `${{ env.LATEST_BRANCH }}` inside a `run:` PowerShell block. Critically, RELEASE_BRANCH is set from `inputs.major` (a workflow_dispatch user input), making this attacker-controllable: `$latest = '${{ env.RELEASE_BRANCH }}' -eq '${{ env.LATEST_BRANCH }}'; Update-Branch -Remote origin -Major ${{ env.RELEASE_BRANCH }} -Latest:$latest;`

Locations:

- `.github/workflows/release.yaml:57`

### unpinned-uses (severity: high)

Multiple workflow files reference third-party actions using mutable version tags instead of full 40-character commit SHA digests, making them vulnerable to supply-chain attacks if the tag is moved to a malicious commit.

analyze.yaml:
  - uses: actions/checkout@v3
  - uses: microsoft/ps-rule@main
  - uses: microsoft/DevSkim-Action@v1
  - uses: github/codeql-action/upload-sarif@v2

build.yaml:
  - uses: actions/checkout@v3 (×2)
  - uses: actions/upload-artifact@v3

dependencies.yaml:
  - uses: actions/checkout@v3

release.yaml:
  - uses: actions/checkout@v3

stale.yaml:
  - uses: actions/stale@v8

Locations:

- `.github/workflows/analyze.yaml:26`
- `.github/workflows/analyze.yaml:30`
- `.github/workflows/analyze.yaml:40`
- `.github/workflows/analyze.yaml:44`
- `.github/workflows/analyze.yaml:48`
- `.github/workflows/build.yaml:14`
- `.github/workflows/build.yaml:47`
- `.github/workflows/build.yaml:63`
- `.github/workflows/dependencies.yaml:27`
- `.github/workflows/release.yaml:44`
- `.github/workflows/stale.yaml:17`

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

Fixed all findings across 6 files:

1. action.yml: Moved all 15 inputs.* expressions and github.action_path out of the run: block into an env: block. PowerShell command now uses $env:VAR_NAME references. github.action_path replaced with built-in $env:GITHUB_ACTION_PATH.

2. .github/workflows/dependencies.yaml: Moved ${{ env.WORKING_BRANCH }} into step env: block as WORKING_BRANCH_NAME; pinned actions/checkout@v3 to SHA a37ce9120846195fa4ece8f58b268e6043cb2f26.

3. .github/workflows/release.yaml: Moved ${{ env.RELEASE_BRANCH }} and ${{ env.LATEST_BRANCH }} into step env: block as STEP_RELEASE_BRANCH and STEP_LATEST_BRANCH; pinned actions/checkout@v3 to SHA.

4. .github/workflows/analyze.yaml: Pinned actions/checkout@v3, microsoft/ps-rule@main, microsoft/DevSkim-Action@v1, and github/codeql-action/upload-sarif@v2 to full commit SHAs.

5. .github/workflows/build.yaml: Pinned both actions/checkout@v3 references and actions/upload-artifact@v3 to full commit SHAs.

6. .github/workflows/stale.yaml: Pinned actions/stale@v8 to full commit SHA.

All original tag names preserved as inline comments for readability.

