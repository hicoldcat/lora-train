import argparse
import modules.textual_inversion.preprocess as preprocess
from modules.shared import cmd_opts
# parser = argparse.ArgumentParser(description="Dataset preprocess")
# parser.add_argument("--src", type=str,help="源目录")
# parser.add_argument("--dst", type=str,help="目标目录")
# parser.add_argument("--width", type=int, default=512)
# parser.add_argument("--height", type=int, default=512)
# parser.add_argument("--txtAction", type=str, default="ignore")
# parser.add_argument("--keepOriginalSize", type=bool, default=False)
# parser.add_argument("--flip", type=bool, default=False)
# parser.add_argument("--split", type=bool, default=False)
# parser.add_argument("--caption", type=bool, default=False)
# parser.add_argument("--captionDeepbooru", type=bool, default=True)
# parser.add_argument("--splitThreshold", type=float, default=0.5)
# parser.add_argument("--overlapRatio", type=float, default=0.2)
# parser.add_argument("--focalCrop", type=bool, default=True)
# parser.add_argument("--focalCropFaceWeight", type=float, default=1)
# parser.add_argument("--focalCropEntropyWeight", type=float, default=0)
# parser.add_argument("--focalCropEdgesWeight", type=float, default=0)
# parser.add_argument("--focalCropDebug", type=bool, default=False)
# parser.add_argument("--multicrop", type=bool, default=False)
# parser.add_argument("--multicropMindim", type=int, default=384)
# parser.add_argument("--multicropMaxdim", type=int, default=768)
# parser.add_argument("--multicropMinarea", type=int, default=4096)
# parser.add_argument("--multicropMaxarea", type=int, default=409600)
# parser.add_argument("--multicropObjective", type=str, default="Maximize area")
# parser.add_argument("--multicropThreshold", type=float, default=0.1)

if __name__ == '__main__':
    preprocess.preprocess(
        None,
        cmd_opts.preprocess_src,  # process_src, Source directory
        cmd_opts.preprocess_dst,  # process_dst, Destination directory
        cmd_opts.preprocess_width,  # process_width,Width
        cmd_opts.preprocess_height,  # process_height, Height
        cmd_opts.preprocess_txtAction,  # preprocess_txt_action, Existing Caption txt Action
        cmd_opts.preprocess_keepOriginalSize,  # process_keep_original_size, Keep original size
        cmd_opts.preprocess_flip,  # process_flip, Create flipped copies创建水平翻转副本
        cmd_opts.preprocess_split,  # process_split,Split oversized images分割过大的图像
        cmd_opts.preprocess_caption,  # process_caption, Use BLIP for caption使用 BLIP 生成标签 (自然语言）
        cmd_opts.preprocess_captionDeepbooru,  # process_caption_deepbooru = False, Use deepbooru for caption使用 Deepbooru 生成标签
        cmd_opts.preprocess_splitThreshold,  # split_threshold = 0.5,Split image threshold
        cmd_opts.preprocess_overlapRatio,  # overlap_ratio = 0.2,Split image overlap ratio
        cmd_opts.preprocess_focalCrop,  # process_focal_crop = False,Auto focal point crop自动面部焦点剪裁
        cmd_opts.preprocess_focalCropFaceWeight,  # process_focal_crop_face_weight = 0.9, Focal point face weight
        cmd_opts.preprocess_focalCropEntropyWeight,  # process_focal_crop_entropy_weight = 0.3,Focal point entropy weight
        cmd_opts.preprocess_focalCropEdgesWeight,  # process_focal_crop_edges_weight = 0.5,Focal point edges weight
        cmd_opts.preprocess_focalCropDebug,  # process_focal_crop_debug = False,Create debug image
        cmd_opts.preprocess_multicrop,  # process_multicrop = None, Auto-sized crop自动按比例剪裁缩放
        cmd_opts.preprocess_multicropMindim,  # process_multicrop_mindim = None, Dimension lower bound
        cmd_opts.preprocess_multicropMaxdim,  # process_multicrop_maxdim = None, Dimension upper bound
        cmd_opts.preprocess_multicropMinarea,  # process_multicrop_minarea = None, Area lower bound
        cmd_opts.preprocess_multicropMaxarea,  # process_multicrop_maxarea = None, Area upper bound
        cmd_opts.preprocess_multicropObjective,  # process_multicrop_objective = None, Maximize area
        cmd_opts.preprocess_multicropThreshold  # process_multicrop_threshold = None Error threshold
    )