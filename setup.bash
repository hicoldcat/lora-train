echo "正在创建虚拟环境..."

python3 -m venv venv

source venv/bin/activate

$cn_source = $1

# cd ./sd-scripts

if [ -n "$cn_source" ]; then
    echo "安装 torch & xformers..."
    pip install torch==2.0.0+cu118 torchvision==0.15.1+cu118 --extra-index-url https://mirrors.bfsu.edu.cn/pypi/web/simple
    pip install xformers==0.0.19  --extra-index-url https://mirrors.bfsu.edu.cn/pypi/web/simple

    echo "安装依赖..."
    
    cd ./preprocess_tools

    pip install --upgrade -r requirements.txt --extra-index-url https://mirrors.bfsu.edu.cn/pypi/web/simple

    cd ../sd-scripts

    pip install --upgrade -r requirements.txt  --extra-index-url https://mirrors.bfsu.edu.cn/pypi/web/simple
    pip install --upgrade lion-pytorch lycoris-lora dadaptation wandb  --extra-index-url https://mirrors.bfsu.edu.cn/pypi/web/simple
else
    echo "安装 torch & xformers..."
    pip install torch==2.0.0+cu118 torchvision==0.15.1+cu118 --extra-index-url https://download.pytorch.org/whl/cu118
    pip install xformers==0.0.19

    echo "安装依赖..."

    cd ./preprocess_tools
    pip install --upgrade -r requirements.txt

    cd ../sd-scripts

    pip install --upgrade -r requirements.txt
    pip install --upgrade lion-pytorch lycoris-lora dadaptation wandb

    
echo "安装完毕"

exit
