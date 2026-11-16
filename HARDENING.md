<!-- markdownlint-disable -->

# Hardening Report: microsoft--ps-rule/v2.8.1

> This file was generated automatically by the hardening agent.

**Policy SHA:** `374911c4be584df24e6da57af2d990570ef0f859`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **microsoft--ps-rule/v2.8.1** was hardened automatically. 17 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### script-injection (severity: high)

Rule (a): The composite step 'Analysis' (shell: pwsh) puts GitHub expressions straight into the run: script: `${{ github.action_path }}/powershell.ps1 -InputType '${{ inputs.inputType }}' -InputPath '${{ inputs.inputPath }}' -Modules '${{ inputs.modules }}' ... -Version '${{ inputs.version }}'`. Every inputs.* value (inputType, inputPath, modules, source, baseline, conventions, option, outcome, outputFormat, outputPath, path, prerelease, repository, summary, version) is pasted into the PowerShell script text before it runs. A value containing a single quote can close the string and run any PowerShell command. To fix this, move each input into the step's env: block (e.g. INPUT_TYPE: ${{ inputs.inputType }}) and pass it as "$env:INPUT_TYPE". Call the script as `& "$env:GITHUB_ACTION_PATH/powershell.ps1"` instead of using ${{ github.action_path }}.

Locations:

- `action.yml:91`

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

### prior-fix (severity: high)

Carried forward from this version's previous harden, which fixed it; fix it again unless the code no longer has the problem. The previous harden changed action.yml without recording a finding for it, and this analysis reported nothing there. Re-apply its security changes unless the code no longer needs them. The previous patch:
```diff
diff --git a/action.yml b/action.yml
index 9e50644..16e78b3 100644
--- a/action.yml
+++ b/action.yml
@@ -12,82 +12,101 @@ inputs:
     description: 'Determines the type of input to use for PSRule.'
     default: 'repository'
     required: false
-
   inputPath:
     description: 'The path PSRule will look for files to validate.'
     default: ''
     required: false
-
   modules:
     description: 'A comma separated list of modules to use for analysis.'
     default: ''
     required: false
-
   source:
     description: 'An path containing rules to use for analysis.'
     default: '.ps-rule/'
     required: false
-
   baseline:
     description: 'The name of a PSRule baseline to use.'
     default: ''
     required: false
-
   conventions:
     description: 'A comma separated list of conventions to use.'
     default: ''
     required: false
-
   option:
     description: 'The path to an options file.'
     default: ''
     required: false
-
   outcome:
     description: 'Filters output to include results with the specified outcome.'
     default: ''
     required: false
-
   outputFormat:
     description: 'The format to use when writing results to disk. When set to None results are not written to disk.'
     default: 'None'
     required: false
-
   outputPath:
     description: 'The file path to write results to.'
     default: ''
     required: false
-
   path:
     description: 'The working directory PSRule is run from.'
     default: ''
     required: false
-
   prerelease:
     description: 'Determine if a pre-release module version is installed.'
     default: 'false'
     required: false
-
   repository:
     description: 'The name of the PowerShell repository where PSRule modules are installed from. By default this is the PowerShell Gallery.'
     default: 'PSGallery'
     required: false
-
   summary:
     description: 'Determines if a job summary is written.'
     default: 'true'
     required: false
-
   version:
     description: 'The specific version of PSRule to use.'
     default: ''
     required: false
-
 runs:
   using: 'composite'
   steps:
     - name: 'Analysis'
       shell: pwsh
       working-directory: ${{ github.workspace }}
+      env:
+        ACTION_PATH: ${{ github.action_path }}
+        INPUT_INPUT_TYPE: ${{ inputs.inputType }}
+        INPUT_INPUT_PATH: ${{ inputs.inputPath }}
+        INPUT_MODULES: ${{ inputs.modules }}
+        INPUT_SOURCE: ${{ inputs.source }}
+        INPUT_BASELINE: ${{ inputs.baseline }}
+        INPUT_CONVENTIONS: ${{ inputs.conventions }}
+        INPUT_OPTION: ${{ inputs.option }}
+        INPUT_OUTCOME: ${{ inputs.outcome }}
+        INPUT_OUTPUT_FORMAT: ${{ inputs.outputFormat }}
+        INPUT_OUTPUT_PATH: ${{ inputs.outputPath }}
+        INPUT_PATH: ${{ inputs.path }}
+        INPUT_PRERELEASE: ${{ inputs.prerelease }}
+        INPUT_REPOSITORY: ${{ inputs.repository }}
+        INPUT_SUMMARY: ${{ inputs.summary }}
+        INPUT_VERSION: ${{ inputs.version }}
       run: |-
-        ${{ github.action_path }}/powershell.ps1 -InputType '${{ inputs.inputType }}' -InputPath '${{ inputs.inputPath }}' -Modules '${{ inputs.modules }}' -Source '${{ inputs.source }}' -Baseline '${{ inputs.baseline }}' -Conventions '${{ inputs.conventions }}' -Option '${{ inputs.option }}' -Outcome '${{ inputs.outcome }}' -OutputFormat '${{ inputs.outputFormat }}' -OutputPath '${{ inputs.outputPath }}' -Path '${{ inputs.path }}' -PreRelease '${{ inputs.prerelease }}' -Repository '${{ inputs.repository }}' -Summary '${{ inputs.summary }}' -Version '${{ inputs.version }}'
+        & "$env:ACTION_PATH/powershell.ps1" -InputType $env:INPUT_INPUT_TYPE -InputPath $env:INPUT_INPUT_PATH -Modules $env:INPUT_MODULES -Source $env:INPUT_SOURCE -Baseline $env:INPUT_BASELINE -Conventions $env:INPUT_CONVENTIONS -Option $env:INPUT_OPTION -Outcome $env:INPUT_OUTCOME -OutputFormat $env:INPUT_OUTPUT_FORMAT -OutputPath $env:INPUT_OUTPUT_PATH -Path $env:INPUT_PATH -PreRelease $env:INPUT_PRERELEASE -Repository $env:INPUT_REPOSITORY -Summary $env:INPUT_SUMMARY -Version $env:INPUT_VERSION

```

Locations:

- `action.yml`

## Iteration Notes

### Iteration 1

**Fixes applied:** script-injection, static-inline-injection, prior-fix

**Notes:**

Fixed the script injection in the 'Analysis' step of action.yml (shell: pwsh). The 15 inputs are no longer pasted into the script text. Each one now goes into the step's env: block (PSRULE_* names) and reaches powershell.ps1 as a double-quoted "$env:PSRULE_*" argument, so a single quote or other PowerShell syntax in an input is just text. The script is called as & "$env:GITHUB_ACTION_PATH/powershell.ps1" instead of through the ${{ github.action_path }} expression. Empty inputs still arrive as empty strings, the same as upstream's '' literals. Every parameter in powershell.ps1 is a [String], and the script already handles empty values, so its behaviour is unchanged. This re-applies the previous harden's fix (prior-fix) in a safer form: arguments are now quoted, and the PSRULE_* names stay clear of the INPUT_* defaults the script reads (for example, it reads INPUT_INPUTTYPE, while the earlier patch set INPUT_INPUT_TYPE). Nothing was run to test the change.

