#!/bin/bash
#SBATCH --job-name=odt-lp
#SBATCH --open-mode=append
#SBATCH --output=logs/out/%x_%j.txt
#SBATCH --error=logs/err/%x_%j.txt
#SBATCH --time=240:00:00
#SBATCH --mem=40G
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:TITAN:1
#SBATCH --account=co_rail
#SBATCH --partition=savio3_gpu
#SBATCH --qos=rail_gpu3_normal

TASK_ID=$((SLURM_ARRAY_TASK_ID-1))

BETAS="1;2;3;"

arrBETAS=(${BETAS//;/ })

BETA=${arrBETAS[$TASK_ID]}

module load gnu-parallel

export PROJECT_DIR="/global/home/users/$USER/online-dt"
export LOG_DIR="/global/scratch/users/$USER/online-dt"
export PROJECT_NAME="odt-antmaze"
export dataset_path=/global/scratch/users/nakamoto/data

run_singularity ()
{
singularity exec --nv --writable-tmpfs -B /usr/lib64 -B /var/lib/dcv-gl --overlay /global/scratch/users/nakamoto/singularity/overlay-50G-10M-2.ext3:ro /global/scratch/users/nakamoto/singularity/cuda11.5-cudnn8-devel-ubuntu18.04.sif /bin/bash -c "
    source ~/.bashrc

    if [[ $HOSTNAME == n02* ]]; then
        conda activate odt-2
    else
        conda activate odt
    fi

    cd $PROJECT_DIR
    python main.py \
    --seed=$1 \
    --num_updates_per_pretrain_iter=7000 \
    --max_env_steps=1000000 \
    --env=$2 \
    --embed_dim=1024 \
    --eval_interval=10 \
    --num_eval_episodes=20 \
    --eval_context_length=5 \
    --ordering=1 \
    --eval_rtg=1 \
    --online_rtg=2 \
    --replay_size=1500 \
    --learning_rate=0.001 \
    --weight_decay=0 \
    --project=$PROJECT_NAME \
    --dataset_path=$dataset_path \
    --num_workers=4 \
    --env_type=dummy \
    --save_dir=$LOG_DIR/exp
"
}

export -f run_singularity
parallel --delay 20 --linebuffer -j 1 run_singularity $BETA {} \
    ::: antmaze-large-play-v2 