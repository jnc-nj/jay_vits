FROM nvcr.io/nvidia/tensorrt:22.04-py3

RUN git clone https://github.com/Plachtaa/VITS-fast-fine-tuning.git
RUN cd VITS-fast-fine-tuning && pip install -r requirements.txt
RUN pip install imageio==2.4.1
RUN pip install moviepy
RUN pip install --upgrade numpy

RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install --no-install-recommends tzdata -y ffmpeg

ENTRYPOINT ["/bin/bash"]

# docker run -it --gpus 1 -p 7861:7860 --entrypoint /bin/bash -v /data/VITS-fast-fine-tuning:/workspace/VITS-fast-fine-tuning --shm-size=512M vits

# tensorboard --logdir OUTPUT_MODEL --bind_all --port 7860

# wget https://huggingface.co/jackyqs/vits-aishell3-175-chinese/resolve/main/D_AISHELL.pth -O ./pretrained_models/D_0.pth
# wget https://huggingface.co/jackyqs/vits-aishell3-175-chinese/resolve/main/G_AISHELL.pth -O ./pretrained_models/G_0.pth
# wget https://huggingface.co/jackyqs/vits-aishell3-175-chinese/resolve/main/config.json -O ./configs/finetune_speaker.json

# wget https://huggingface.co/datasets/Plachta/sampled_audio4ft/resolve/main/VITS-Chinese/D_0.pth -O ./pretrained_models/D_0.pth
# wget https://huggingface.co/datasets/Plachta/sampled_audio4ft/resolve/main/VITS-Chinese/G_0.pth -O ./pretrained_models/G_0.pth
# wget https://huggingface.co/datasets/Plachta/sampled_audio4ft/resolve/main/VITS-Chinese/config.json -O ./configs/finetune_speaker.json

# pip install --upgrade numpy
# python VC_inference.py --model_dir ./OUTPUT_MODEL/G_35000.pth --config_dir ./configs/modified_finetune_speaker.json --share True

# python scripts/video2audio.py
# python scripts/denoise_audio.py
# python scripts/long_audio_transcribe.py --languages "C" --whisper_size large
# python scripts/short_audio_transcribe.py --languages "C" --whisper_size large
# python scripts/resample.py

# python preprocess_v2.py --languages "C"
# python preprocess_v2.py --add_auxiliary_data True --languages "C"

# python finetune_speaker_v2.py -m ./OUTPUT_MODEL --max_epochs "10000" --preserved 50 --drop_speaker_embed True
# python finetune_speaker_v2.py -m ./OUTPUT_MODEL --max_epochs "10000" --preserved 50 --drop_speaker_embed False --cont True
