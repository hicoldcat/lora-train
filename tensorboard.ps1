
[CmdletBinding()]
Param (
  [Parameter(Mandatory = $true)]
  [string]$logdir,
  [int]$port = 7788
)

$Env:TF_CPP_MIN_LOG_LEVEL = "3"

.\venv\Scripts\activate

pip uninstall -y tb-nightly tensorboard tensorflow tensorflow-estimator
pip install tensorflow==2.10.1 -i https://mirrors.bfsu.edu.cn/pypi/web/simple # or `tensorflow-gpu`, or `tf-nightly`, ...

python -m tensorboard.main --logdir=$logdir --port=$port
# python .\diagnose_tensorboard.py