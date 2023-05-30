# 通过Start-Process执行
param (
  [string]$config_file,
  [int]$num_cpu_threads_per_process = 1,
  [int]$utf8 = 1
)

function ProcessFail {
  param (
      $ErrorInfo
  )
  Write-Output $ErrorInfo
  Read-Host | Out-Null ;
}

.\venv\Scripts\activate

$Env:HF_HOME = "huggingface"
$Env:XFORMERS_FORCE_DISABLE_TRITON = "1"

if ($utf8 -eq 1) {
  $Env:PYTHONUTF8 = 1
}

Write-Output "开始训练模型..."

try{
  python -m accelerate.commands.launch --num_cpu_threads_per_process=$num_cpu_threads_per_process "./sd-scripts/train_network.py" --config_file=$config_file
} catch{
  ProcessFail "训练失败"
}

Write-Output "训练模型完成"