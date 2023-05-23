
[CmdletBinding()]
Param (
  [Parameter(Mandatory = $true)]
  [string]$config_file,
  [int]$num_cpu_threads_per_process = 1,
  [int]$utf8 = 1
)

$pythonProcess = $null

.\venv\Scripts\activate

$Env:HF_HOME = "huggingface"

if ($utf8 -eq 1) {
  $Env:PYTHONUTF8 = 1
}

# python -m accelerate.commands.launch --num_cpu_threads_per_process=$num_cpu_threads_per_process "./sd-scripts/train_network.py" --config_file=$config_file

$pythonProcess = Start-Process -FilePath python -ArgumentList "-m", "accelerate.commands.launch", "--num_cpu_threads_per_process=$num_cpu_threads_per_process", "./sd-scripts/train_network.py", "--config_file=$config_file" -NoNewWindow -PassThru 

$pythonPid = $pythonProcess.Id

Write-Host "Python-Process-ID=$pythonPid"