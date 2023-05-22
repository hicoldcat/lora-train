#!/bin/bash
utf8=1 
num_cpu_threads_per_process=8

export HF_HOME="huggingface"
export TF_CPP_MIN_LOG_LEVEL=3


if [[ $utf8 == 1 ]]; then export PYTHONUTF8=1; fi
if [ -n "$1" ]; then $num_cpu_threads_per_process = $1; fi
if [ -n "$2" ]; then $config_file = $2; fi

python -m accelerate.commands.launch --num_cpu_threads_per_process=$num_cpu_threads_per_process "./sd-scripts/train_network.py" \
  --config_file=$config_file