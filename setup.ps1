$Env:PIP_DISABLE_PIP_VERSION_CHECK = 1
$Env:PIP_NO_CACHE_DIR = 1
function InstallFail {
    Write-Host "Installation Failed" -ForegroundColor red
    # Write-Host "Red on white text." -ForegroundColor red -BackgroundColor white
    Read-Host | Out-Null ;
    Exit
}

function Check {
    param (
        $ErrorInfo
    )
    if (!($?)) {
        Write-Host $ErrorInfo -ForegroundColor red
        InstallFail
    }
}

if (!(Test-Path -Path "venv")) {
    Write-Host "Creating python virtual environment..." -ForegroundColor blue
    # TODO:使用内置py310的python
    python -m venv venv
    Check "Failed to create virtual environment. Please check if Python is installed and if the Python version is a 64 bit version of Python 3.10, or if the Python directory is in the environment variable PATH."
}

.\venv\Scripts\activate
Check "Failed to activate virtual environment."

Set-Location .\sd-scripts

pip install torch==2.0.0+cu118 torchvision==0.15.1+cu118 -f https://mirror.sjtu.edu.cn/pytorch-wheels/torch_stable.html -i https://mirrors.bfsu.edu.cn/pypi/web/simple
Check "torch==2.0.0 && torchvision==0.15.1 install failed. Please delete the venv folder and run again."

pip install -U -I --no-deps xformers==0.0.17 -i https://mirrors.bfsu.edu.cn/pypi/web/simple
Check "xformers==0.0.17 install failed."

pip install --upgrade -r requirements.txt -i https://mirrors.bfsu.edu.cn/pypi/web/simple
Check "kohya-ss/sd-scripts requirements installation failed"

Write-Host "bitsandbytes updating..."  -ForegroundColor blue
cp .\bitsandbytes_windows\*.dll ..\venv\Lib\site-packages\bitsandbytes\
cp .\bitsandbytes_windows\cextension.py ..\venv\Lib\site-packages\bitsandbytes\cextension.py
cp .\bitsandbytes_windows\main.py ..\venv\Lib\site-packages\bitsandbytes\cuda_setup\main.py

Write-Host "Installation completed." -ForegroundColor green
Read-Host | Out-Null ;