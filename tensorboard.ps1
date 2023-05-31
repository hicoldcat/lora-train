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

Write-Output "���� http://localhost:${port} ������Tensorboard..."

$HasReInstall= $false

function FixTensorboardConflicting{
  if($HasReInstall){
    ProcessFail "Tensorboard����ʧ��"
  } else {
    pip uninstall tb-nightly tensorboardX tensorboard -y
    pip install tensorboard==2.10.1 -i https://mirrors.bfsu.edu.cn/pypi/web/simple
    $HasReInstall=$true
    ProcessStart
  }
}

function ProcessStart {
  try{
    $pythonProcess = Start-Process -FilePath python -ArgumentList "-m", "tensorboard.main", "--logdir=$logdir", "--port=$port" -NoNewWindow -PassThru -Wait
    $pythonProcess.WaitForExit()
    if($pythonProcess.ExitCode -ne 0) {
      FixTensorboardConflicting
    }
  } catch{
    ProcessFail "Tensorboard����ʧ��"
  }
}

ProcessStart