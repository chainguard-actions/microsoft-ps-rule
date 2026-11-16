<!-- markdownlint-disable -->

# Hardening Report: microsoft--ps-rule/v2.9.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `374911c4be584df24e6da57af2d990570ef0f859`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **microsoft--ps-rule/v2.9.0** was hardened automatically. 17 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### script-injection (severity: high)

Rule (a) violated: GitHub Actions expressions are put straight into the pwsh run: script of the 'Analysis' step. The offending line is: `${{ github.action_path }}/powershell.ps1 -InputType '${{ inputs.inputType }}' -InputPath '${{ inputs.inputPath }}' -Modules '${{ inputs.modules }}' ... -Version '${{ inputs.version }}'`. The runner substitutes every inputs.* value and github.action_path into the script text before PowerShell parses it. A value containing a single quote ends the quoted string, so any following PowerShell code runs (e.g. `x'; Invoke-Expression ...; '`). The working-directory value (`${{ github.workspace }}`) is not part of the script. Fix: pass each input through an env: variable (e.g. INPUT_INPUTTYPE: ${{ inputs.inputType }}) and reference it as $env:INPUT_INPUTTYPE. Call the script as & "$env:GITHUB_ACTION_PATH/powershell.ps1".

Locations:

- `action.yml:93`

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
index 9e50644..b764947 100644
--- a/action.yml
+++ b/action.yml
@@ -12,82 +12,100 @@ inputs:
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
+        INPUT_TYPE: ${{ inputs.inputType }}
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
+        & "$env:GITHUB_ACTION_PATH/powershell.ps1" -InputType $env:INPUT_TYPE -InputPath $env:INPUT_INPUT_PATH -Modules $env:INPUT_MODULES -Source $env:INPUT_SOURCE -Baseline $env:INPUT_BASELINE -Conventions $env:INPUT_CONVENTIONS -Option $env:INPUT_OPTION -Outcome $env:INPUT_OUTCOME -OutputFormat $env:INPUT_OUTPUT_FORMAT -OutputPath $env:INPUT_OUTPUT_PATH -Path $env:INPUT_PATH -PreRelease $env:INPUT_PRERELEASE -Repository $env:INPUT_REPOSITORY -Summary $env:INPUT_SUMMARY -Version $env:INPUT_VERSION

```

Locations:

- `action.yml`

## Iteration Notes

### Iteration 1

**Fixes applied:** script-injection, static-inline-injection, prior-fix

**Notes:**

I moved every inputs.* expression in the pwsh 'Analysis' step of action.yml into the step's env: block. Each one gets the INPUT_* name that powershell.ps1 already uses for its parameter defaults (e.g. INPUT_INPUTTYPE, INPUT_OUTPUTFORMAT). The script is now called as & "$env:GITHUB_ACTION_PATH/powershell.ps1" and each argument is passed as "$env:INPUT_X" in double quotes, so the script gets the same string values it got before. The ${{ github.workspace }} expression in working-directory is unchanged, since it is not part of the script. This re-applies the previous harden's fix, but with env names that line up with the script's own defaults. Nothing was run or tested.

