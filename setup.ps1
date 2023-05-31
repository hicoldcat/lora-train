# 通过./执行
[CmdletBinding()]
Param (
  [String]$CNSOURCE
)

$Env:HF_HOME = "huggingface"
$Env:PIP_DISABLE_PIP_VERSION_CHECK = 1
$Env:PIP_NO_CACHE_DIR = 1


function InstallFail {
    Write-Output "安装失败。"
    return
    Read-Host | Out-Null ;
}

function Check {
    param (
        $ErrorInfo
    )
    if (!($?)) {
        Write-Output $ErrorInfo
        InstallFail
    }
}

if (!(Test-Path -Path "venv")) {
    Write-Output "正在创建虚拟环境..."
    python -m venv venv
    Check "创建虚拟环境失败，请检查 python 是否安装完毕以及 python 版本是否为64位版本的python 3.10、或python的目录是否在环境变量PATH内。"
}

.\venv\Scripts\activate
Check "激活虚拟环境失败。"


if($CNSOURCE -eq "true"){
    Write-Output "使用国内加速安装程序所需依赖"

    pip install torch==2.0.0+cu118 torchvision==0.15.1+cu118 -f https://mirror.sjtu.edu.cn/pytorch-wheels/torch_stable.html -i https://mirrors.bfsu.edu.cn/pypi/web/simple --progress-bar=on
    Check "torch 安装失败，请删除 venv 文件夹后重新运行。"

    pip install -U -I --no-deps xformers==0.0.19 -i https://mirrors.bfsu.edu.cn/pypi/web/simple --progress-bar=on
    Check "xformers 安装失败。"

    Set-Location .\preprocess_tools

    pip install --upgrade -r requirements.txt -i https://mirrors.bfsu.edu.cn/pypi/web/simple
    Check "数据集预处理依赖安装失败。"

    Set-Location ..\sd-scripts
   
    pip install --upgrade -r requirements.txt -i https://mirrors.bfsu.edu.cn/pypi/web/simple
    Check "sd-scripts依赖安装失败。"

    pip install --upgrade lion-pytorch dadaptation lycoris-lora wandb -i https://mirrors.bfsu.edu.cn/pypi/web/simple
    Check "Lion、dadaptation 优化器、lycoris、wandb安装失败。"

}else {
    Write-Output "安装程序所需依赖"

    pip install torch==2.0.0+cu118 torchvision==0.15.1+cu118 --extra-index-url https://download.pytorch.org/whl/cu118 --progress-bar=on
    Check "torch 安装失败，请删除 venv 文件夹后重新运行。"
    
    pip install --upgrade xformers==0.0.19 --progress-bar=on
    Check "xformers 安装失败。"

    Set-Location .\preprocess_tools

    pip install --upgrade -r requirements.txt 
    Check "数据集预处理依赖安装失败。"

    Set-Location ..\sd-scripts

    pip install --upgrade -r requirements.txt
    Check "sd-scripts依赖安装失败。"

    pip install --upgrade lion-pytorch dadaptation lycoris-lora wandb 
    Check "Lion、dadaptation 优化器、lycoris、wandb安装失败。"
}

Write-Output "安装 bitsandbytes..."

cp .\bitsandbytes_windows\*.dll ..\venv\Lib\site-packages\bitsandbytes\
cp .\bitsandbytes_windows\cextension.py ..\venv\Lib\site-packages\bitsandbytes\cextension.py
cp .\bitsandbytes_windows\main.py ..\venv\Lib\site-packages\bitsandbytes\cuda_setup\main.py

Write-Output "安装完毕"
