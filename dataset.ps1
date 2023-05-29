
[CmdletBinding()]
Param (
  [Parameter(Mandatory = $true)]
  [string]$src,
  [Parameter(Mandatory = $true)]
  [string]$dst,
  [int]$width = 512,
  [int]$height = 512,
  [string]$txtAction = 'ignore',
  [bool]$keepOriginalSize,
  [bool]$flip,
  [bool]$split,
  [bool]$caption,
  [bool]$captionDeepbooru,
  [float]$splitThreshold = 0.5,
  [float]$overlapRatio = 0.2,
  [bool]$focalCrop,
  [float]$focalCropFaceWeight = 0.9,
  [float]$focalCropEntropyWeight = 0.15,
  [float]$focalCropEdgesWeight = 0.5,
  [bool]$focalCropDebug,
  [bool]$multicrop,
  [int]$multicropMindim = 384,
  [int]$multicropMaxdim = 768,
  [int]$multicropMinarea = 4096,
  [int]$multicropMaxarea = 409600,
  [string]$multicropObjective = 'Maximize area',
  [float]$multicropThreshold = 0.1
)

.\venv\Scripts\activate

$launch_bool_args = [System.Collections.ArrayList]::new()

if ($keepOriginalSize) {
  [void]$launch_bool_args.Add("--preprocess-keepOriginalSize")
}
if ($flip) {
  [void]$launch_bool_args.Add("--preprocess-flip")
}
if ($split) {
  [void]$launch_bool_args.Add("--preprocess-split")
}
if ($caption) {
  [void]$launch_bool_args.Add("--preprocess-caption")
}
if ($captionDeepbooru) {
  [void]$launch_bool_args.Add("--preprocess-captionDeepbooru")
}
if ($focalCrop) {
  [void]$launch_bool_args.Add("--preprocess-focalCrop")
}
if ($focalCropDebug) {
  [void]$launch_bool_args.Add("--preprocess-focalCropDebug")
}

if ($multicrop) {
  [void]$launch_bool_args.Add("--preprocess-multicrop")
}

$pythonProcess = Start-Process -FilePath python -ArgumentList ".\preprocess_tools\dataset_preprocess.py" "--preprocess-src=$src" `
    "--preprocess-dst=$dst" `
    "--preprocess-width=$width" `
    "--preprocess-height=$height" `
    "--preprocess-txtAction=$txtAction" `
    "--preprocess-splitThreshold=$splitThreshold" `
    "--preprocess-overlapRatio=$overlapRatio" `
    "--preprocess-focalCropFaceWeight=$focalCropFaceWeight" `
    "--preprocess-focalCropEntropyWeight=$focalCropEntropyWeight" `
    "--preprocess-focalCropEdgesWeight=$focalCropEdgesWeight" `
    "--preprocess-multicropMindim=$multicropMindim" `
    "--preprocess-multicropMaxdim=$multicropMaxdim" `
    "--preprocess-multicropMinarea=$multicropMinarea" `
    "--preprocess-multicropMaxarea=$multicropMaxarea" `
    "--preprocess-multicropObjective=$multicropObjective" `
    "--preprocess-multicropThreshold=$multicropThreshold" `
    $launch_bool_args -NoNewWindow -PassThru 

$pythonPid = $pythonProcess.Id

Write-Host "Python-Process-ID=$pythonPid"