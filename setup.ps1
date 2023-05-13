$Env:PIP_DISABLE_PIP_VERSION_CHECK = 1
$Env:PIP_NO_CACHE_DIR = 1

function InstallFail {
    Write-Host "安装失败" -ForegroundColor red
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
    Write-Host "正在创建虚拟环境..." -ForegroundColor blue
    # TODO:使用内置py310的python
    python -m venv venv
    Check "创建虚拟环境失败，请检查 python 是否安装完毕以及 python 版本是否为64位版本的python 3.10、或python的目录是否在环境变量PATH内。"
}

.\venv\Scripts\activate
Check "激活虚拟环境失败。"

Set-Location .\sd-scripts

$cn_source = $args[0]
if($cn_source -eq "true" -or $cn_source -eq true){
    Write-Output "使用国内加速安装程序所需依赖"

    pip install torch==2.0.0+cu118 torchvision==0.15.1+cu118 -f https://mirror.sjtu.edu.cn/pytorch-wheels/torch_stable.html -i https://mirrors.bfsu.edu.cn/pypi/web/simple
    Check "torch 安装失败，请删除 venv 文件夹后重新运行。"

    pip install -U -I --no-deps xformers==0.0.19 -i https://mirrors.bfsu.edu.cn/pypi/web/simple
    Check "xformers 安装失败。"

    pip install --upgrade -r requirements.txt -i https://mirrors.bfsu.edu.cn/pypi/web/simple
    Check "其他依赖安装失败。"

    pip install --upgrade lion-pytorch dadaptation -i https://mirrors.bfsu.edu.cn/pypi/web/simple
    Check "Lion、dadaptation 优化器安装失败。"

    pip install --upgrade lycoris-lora -i https://mirrors.bfsu.edu.cn/pypi/web/simple
    Check "lycoris 安装失败。"

    pip install --upgrade wandb -i https://mirrors.bfsu.edu.cn/pypi/web/simple
    Check "wandb 安装失败。"

}else {
    Write-Output "安装程序所需依赖"

    pip install torch==2.0.0+cu118 torchvision==0.15.1+cu118 --extra-index-url https://download.pytorch.org/whl/cu118
    Check "torch 安装失败，请删除 venv 文件夹后重新运行。"
    
    pip install --upgrade xformers==0.0.19
    Check "xformers 安装失败。"

    pip install --upgrade -r requirements.txt
    Check "其他依赖安装失败。"

    pip install --upgrade lion-pytorch dadaptation
    Check "Lion、dadaptation 优化器安装失败。"

    pip install --upgrade lycoris-lora
    Check "lycoris 安装失败。"

    pip install --upgrade wandb
    Check "wandb 安装失败。"
}

Write-Host "安装 bitsandbytes..."  -ForegroundColor blue
cp .\bitsandbytes_windows\*.dll ..\venv\Lib\site-packages\bitsandbytes\
cp .\bitsandbytes_windows\cextension.py ..\venv\Lib\site-packages\bitsandbytes\cextension.py
cp .\bitsandbytes_windows\main.py ..\venv\Lib\site-packages\bitsandbytes\cuda_setup\main.py

Write-Output "安装完毕" -ForegroundColor green
Read-Host | Out-Null ;
Exit