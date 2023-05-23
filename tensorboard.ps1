
[CmdletBinding()]
Param (
  [Parameter(Mandatory = $true)]
  [string]$logdir,
  [int]$port = 7788
)

$Env:TF_CPP_MIN_LOG_LEVEL = "3"

.\venv\Scripts\activate

python -m tensorboard.main --logdir=$logdir --port=$port
# python .\diagnose_tensorboard.py