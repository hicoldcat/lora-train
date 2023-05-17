
# [CmdletBinding()]
# Param (
#   [String]$LocalHost,
#   [Int32]$LocalPort
# )

.\venv\Scripts\activate

# pip install torch==2.0.0+cu118 torchvision==0.15.1+cu118 -f https://mirror.sjtu.edu.cn/pytorch-wheels/torch_stable.html -i https://mirrors.bfsu.edu.cn/pypi/web/simple
# pip install -U -I --no-deps xformers==0.0.19 -i https://mirrors.bfsu.edu.cn/pypi/web/simple
# pip install --upgrade -r .\preprocess_tools\requirements.txt -i https://mirrors.bfsu.edu.cn/pypi/web/simple
# pip install --upgrade -r .\preprocess_tools\repositories\BLIP\requirements.txt -i https://mirrors.bfsu.edu.cn/pypi/web/simple
# pip install --upgrade -r .\preprocess_tools\repositories\CodeFormer\requirements.txt -i https://mirrors.bfsu.edu.cn/pypi/web/simple
# pip install --upgrade -r .\preprocess_tools\repositories\k-diffusion\requirements.txt -i https://mirrors.bfsu.edu.cn/pypi/web/simple
# pip install --upgrade -r .\preprocess_tools\repositories\stable-diffusion-stability-ai\requirements.txt -i https://mirrors.bfsu.edu.cn/pypi/web/simple

python .\preprocess_tools\dataset_preprocess.py