import argparse
import os
import subprocess
import sys
import webbrowser

import uvicorn
from fastapi import BackgroundTasks, FastAPI, Request

parser = argparse.ArgumentParser(description="Internal Service for training")
parser.add_argument("--host", type=str, default="localhost")
parser.add_argument("--port", type=int, default=8095,
                    help="Port to run the server on")


def remove_warnings():
    os.environ["TF_CPP_MIN_LOG_LEVEL"] = "3"
    if sys.platform == "win32":
        # disable triton on windows
        os.environ["XFORMERS_FORCE_DISABLE_TRITON"] = "1"
    os.environ["BITSANDBYTES_NOWELCOME"] = "1"
    os.environ["PYTHONWARNINGS"] = "ignore::UserWarning"


def check_git_path():
    work_dir = sys.path[0]
    if sys.platform == "win32":
        git_path = work_dir + "\\git\\cmd\\git.exe"
    else:
        git_path = "git"  # TODO: MAC GIT
    return git_path


def update_sd_scripts():
    local_git = check_git_path()
    subprocess.run([local_git, "--version"])
    subprocess.run([local_git, "submodule", "init"])
    subprocess.run([local_git, "submodule", "update"])


app = FastAPI()  # api server


@app.post("/api/run")
async def create_toml_file(request: Request, background_tasks: BackgroundTasks):
    # acquired = lock.acquire(blocking=False)
    print(12333333)

    # if not acquired:
    #     print("Training is already running / 已有正在进行的训练")
    #     return {"status": "fail", "detail": "Training is already running"}

    # timestamp = datetime.now().strftime("%Y%m%d-%H%M%S")
    # toml_file = f"toml/{timestamp}.toml"
    # toml_data = await request.body()
    # j = json.loads(toml_data.decode("utf-8"))
    # with open(toml_file, "w") as f:
    #     f.write(toml.dumps(j))
    # background_tasks.add_task(run_train, toml_file)
    return {"status": "success"}


@app.middleware("http")
async def add_cache_control_header(request, call_next):
    response = await call_next(request)
    response.headers["Cache-Control"] = "max-age=0"
    return response


if __name__ == "__main__":
    remove_warnings()
    update_sd_scripts()
    args, _ = parser.parse_known_args()
    webbrowser.open(f"http://{args.host}:{args.port}/docs")
    uvicorn.run(app, host=args.host, port=args.port, log_level="error")
