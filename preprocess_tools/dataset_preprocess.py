import os

import modules.textual_inversion.preprocess as preprocess

# parser = argparse.ArgumentParser(description="GUI for training network")

# parser.add_argument("--host", type=str, default="127.0.0.1")
# parser.add_argument("--port", type=int, default=28000,
#                     help="Port to run the server on")


if __name__ == "__main__":
    # args, _ = parser.parse_known_args()
    # print(f"Server started at http://{args.host}:{args.port}")
    preprocess.preprocess(
        None,
        "E:\\image_source",  # process_src, Source directory
        "E:\image_source\\res",  # process_dst, Destination directory
        200,  # process_width,Width
        200,  # process_height, Height
        'ignore',  # preprocess_txt_action, Existing Caption txt Action
        False,  # process_keep_original_size, Keep original size
        True,  # process_flip, Create flipped copies创建水平翻转副本
        False,  # process_split,Split oversized images分割过大的图像

        True,  # process_caption, Use BLIP for caption使用 BLIP 生成标签 (自然语言）
        True,  # process_caption_deepbooru = False, Use deepbooru for caption使用 Deepbooru 生成标签

        0.5,  # split_threshold = 0.5,Split image threshold
        0.2,  # overlap_ratio = 0.2,Split image overlap ratio

        True,  # process_focal_crop = False,Auto focal point crop自动面部焦点剪裁
        1,  # process_focal_crop_face_weight = 0.9, Focal point face weight
        0,  # process_focal_crop_entropy_weight = 0.3,Focal point entropy weight
        0,  # process_focal_crop_edges_weight = 0.5,Focal point edges weight
        False,  # process_focal_crop_debug = False,Create debug image

        True,  # process_multicrop = None, Auto-sized crop自动按比例剪裁缩放
        384,  # process_multicrop_mindim = None, Dimension lower bound
        768,  # process_multicrop_maxdim = None, Dimension upper bound
        4096,  # process_multicrop_minarea = None, Area lower bound
        409600,  # process_multicrop_maxarea = None, Area upper bound
        'Maximize area',  # process_multicrop_objective = None, Maximize area
        0.1  # process_multicrop_threshold = None Error threshold
    )
