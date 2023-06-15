FROM nvcr.io/nvidia/tensorrt:22.04-py3

RUN git clone https://github.com/Plachtaa/VITS-fast-fine-tuning.git
RUN cd VITS-fast-fine-tuning && pip install -r requirements.txt
RUN pip install imageio==2.4.1
RUN pip install moviepy
RUN cd VITS-fast-fine-tuning/monotonic_align && mkdir monotonic_align && python setup.py build_ext --inplace
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install --no-install-recommends tzdata -y ffmpeg

ENTRYPOINT ["/bin/bash"]

# docker run -it --rm --gpus 1 -p 7860:7860 --entrypoint /bin/bash -v /data/jay_vits/configs:/workspace/VITS-fast-fine-tuning/configs -v /data/jay_vits/custom_character_voice:/workspace/VITS-fast-fine-tuning/custom_character_voice -v /data/jay_vits/denoised_audio:/workspace/VITS-fast-fine-tuning/denoised_audio -v /data/jay_vits/pretrained_models:/workspace/VITS-fast-fine-tuning/pretrained_models -v /data/jay_vits/raw_audio:/workspace/VITS-fast-fine-tuning/raw_audio -v /data/jay_vits/segmented_character_voice:/workspace/VITS-fast-fine-tuning/segmented_character_voice -v /data/jay_vits/video_data:/workspace/VITS-fast-fine-tuning/video_data -v /data/jay_vits/sampled_audio4ft:/workspace/VITS-fast-fine-tuning/sampled_audio4ft -v /data/jay_vits/output_model:/workspace/VITS-fast-fine-tuning/OUTPUT_MODEL -v /data/jay_vits/anno:/workspace/VITS-fast-fine-tuning/anno --shm-size=512M vits_fine

# tensorboard --logdir OUTPUT_MODEL --bind_all --port 7860

# wget https://huggingface.co/jackyqs/vits-aishell3-175-chinese/resolve/main/D_AISHELL.pth -O ./pretrained_models/D_0.pth
# wget https://huggingface.co/jackyqs/vits-aishell3-175-chinese/resolve/main/G_AISHELL.pth -O ./pretrained_models/G_0.pth
# wget https://huggingface.co/jackyqs/vits-aishell3-175-chinese/resolve/main/config.json -O ./configs/finetune_speaker.json

# pip install --upgrade numpy
