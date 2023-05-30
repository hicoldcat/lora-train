# ͨ��Start-Processִ��
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

Write-Output "��ʼѵ��ģ��..."

try{
  $pythonProcess = Start-Process -FilePath python -ArgumentList "-m", "accelerate.commands.launch", "--num_cpu_threads_per_process=$num_cpu_threads_per_process", "./sd-scripts/train_network.py", "--config_file=$config_file" -NoNewWindow -PassThru -Wait
  $pythonProcess.WaitForExit()

  if($pythonProcess.ExitCode -eq 0) {
    # ���������˳�
    Write-Output "ѵ��ģ�����"
  } else {
    ProcessFail "ѵ��ʧ��"
  }
} catch{
  ProcessFail "ѵ��ʧ��"
}