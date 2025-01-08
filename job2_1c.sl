#!/bin/bash

#SBATCH --job-name=Guided-Diffusion-US
#SBATCH --qos=all
#SBATCH --nodelist=budbud019
#SBATCH --cpus-per-task=15
#SBATCH --output=slurm_GPU.out
#SBATCH --error=slurm_GPU.err
#SBATCH --time=540

export OPENAI_LOGDIR=/home/yzhang2018@ec-nantes.fr/test/guided-diffusion-us/OPENAI_LOGDIR
echo $OPENAI_LOGDIR

# activate micromamba
source ~/.bashrc
micromamba activate guided-diffusion


# launch python script
# python -c "from PIL import Image; print('ok')" #no problem
echo $LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/micromamba/yzhang2018@ec-nantes.fr/envs/guided-diffusion/lib/
echo $LD_LIBRARY_PATH

python -u /home/yzhang2018@ec-nantes.fr/test/guided-diffusion-us/scripts/image_train.py --data_dir /home/yzhang2018@ec-nantes.fr/test/guided-diffusion-us/datasets/data_save --dataset_type ultrasound_1c --in_channels 1 --image_size 256 --num_channels 256 --num_heads 4 --num_res_blocks 2 --attention_resolutions 32,16,8 --dropout 0.0 --learn_sigma True --use_scale_shift_norm True --use_fp16 True --resblock_updown True --num_heads_upsample -1 --num_head_channels 64 --class_cond False --use_new_attention_order False --diffusion_steps 1000 --noise_schedule linear --lr 1e-4 --batch_size 64 --microbatch 4 --log_interval 20 --save_interval 1000 --use_checkpoint False --resume_checkpoint /home/yzhang2018@ec-nantes.fr/test/guided-diffusion-us/OPENAI_LOGDIR/model000000.pt

