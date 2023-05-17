$Env:HF_HOME = "huggingface"
$Env:PIP_DISABLE_PIP_VERSION_CHECK = 1
$Env:PIP_NO_CACHE_DIR = 1

[CmdletBinding()]
Param (
  [String]$CNSOURCE
)

function InstallFail {
    Write-Output "��װʧ�ܡ�"
    Read-Host | Out-Null ;
    Exit
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
    Write-Output "���ڴ������⻷��..."
    python -m venv venv
    Check "�������⻷��ʧ�ܣ����� python �Ƿ�װ����Լ� python �汾�Ƿ�Ϊ64λ�汾��python 3.10����python��Ŀ¼�Ƿ��ڻ�������PATH�ڡ�"
}

.\venv\Scripts\activate
Check "�������⻷��ʧ�ܡ�"


if($CNSOURCE -eq "true"){
    Write-Output "ʹ�ù��ڼ��ٰ�װ������������"

    pip install torch==2.0.0+cu118 torchvision==0.15.1+cu118 -f https://mirror.sjtu.edu.cn/pytorch-wheels/torch_stable.html -i https://mirrors.bfsu.edu.cn/pypi/web/simple --progress-bar=on
    Check "torch ��װʧ�ܣ���ɾ�� venv �ļ��к��������С�"

    pip install -U -I --no-deps xformers==0.0.19 -i https://mirrors.bfsu.edu.cn/pypi/web/simple --progress-bar=on
    Check "xformers ��װʧ�ܡ�"

    pip install --upgrade -r .\sd-scripts\requirements.txt -i https://mirrors.bfsu.edu.cn/pypi/web/simple
    Check "sd-scripts������װʧ�ܡ�"

    pip install --upgrade -r .\preprocess_tools\requirements.txt -i https://mirrors.bfsu.edu.cn/pypi/web/simple
    Check "���ݼ�Ԥ����������װʧ�ܡ�"

    pip install --upgrade -r .\preprocess_tools\repositories\BLIP\requirements.txt -i https://mirrors.bfsu.edu.cn/pypi/web/simple
    Check "BLIP������װʧ�ܡ�"

    pip install --upgrade -r .\preprocess_tools\repositories\k-diffusion\requirements.txt -i https://mirrors.bfsu.edu.cn/pypi/web/simple
    Check "k-diffusion������װʧ�ܡ�"

    pip install --upgrade -r .\preprocess_tools\repositories\stable-diffusion-stability-ai\requirements.txt -i https://mirrors.bfsu.edu.cn/pypi/web/simple
    Check "stable-diffusion-stability-ai������װʧ�ܡ�"

    pip install --upgrade lion-pytorch dadaptation lycoris-lora wandb -i https://mirrors.bfsu.edu.cn/pypi/web/simple
    Check "Lion��dadaptation �Ż�����lycoris��wandb��װʧ�ܡ�"

}else {
    Write-Output "��װ������������"

    pip install torch==2.0.0+cu118 torchvision==0.15.1+cu118 --extra-index-url https://download.pytorch.org/whl/cu118 --progress-bar=on
    Check "torch ��װʧ�ܣ���ɾ�� venv �ļ��к��������С�"
    
    pip install --upgrade xformers==0.0.19 --progress-bar=on
    Check "xformers ��װʧ�ܡ�"

    pip install --upgrade -r .\sd-scripts\requirements.txt
    Check "sd-scripts������װʧ�ܡ�"

    pip install --upgrade -r .\preprocess_tools\requirements.txt 
    Check "���ݼ�Ԥ����������װʧ�ܡ�"

    pip install --upgrade -r .\preprocess_tools\repositories\BLIP\requirements.txt 
    Check "BLIP������װʧ�ܡ�"

    pip install --upgrade -r .\preprocess_tools\repositories\k-diffusion\requirements.txt 
    Check "k-diffusion������װʧ�ܡ�"

    pip install --upgrade -r .\preprocess_tools\repositories\stable-diffusion-stability-ai\requirements.txt 
    Check "stable-diffusion-stability-ai������װʧ�ܡ�"

    pip install --upgrade lion-pytorch dadaptation lycoris-lora wandb 
    Check "Lion��dadaptation �Ż�����lycoris��wandb��װʧ�ܡ�"
}

Write-Output "��װ bitsandbytes..."

cp .\bitsandbytes_windows\*.dll ..\venv\Lib\site-packages\bitsandbytes\
cp .\bitsandbytes_windows\cextension.py ..\venv\Lib\site-packages\bitsandbytes\cextension.py
cp .\bitsandbytes_windows\main.py ..\venv\Lib\site-packages\bitsandbytes\cuda_setup\main.py

Write-Output "��װ���"
return
Read-Host | Out-Null ;
