param (
  [string]$logdir,
  [int]$port = 7788
)

function ProcessFail {
  param (
      $ErrorInfo
  )
  Write-Output $ErrorInfo
  Read-Host | Out-Null ;
}

.\venv\Scripts\activate

$Env:XFORMERS_FORCE_DISABLE_TRITON = "1"

# python .\diagnose_tensorboard.py

Write-Output "正在 http://localhost:${port} 上启动Tensorboard..."

try{
  python -m tensorboard.main --logdir=$logdir --port=$port
} catch {
  ProcessFail "Tensorboard启动失败"
}

Write-Output "Tensorboard已启动"