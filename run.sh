export CUDA_VISIBLE_DEVICES=1
export D4RL_SUPPRESS_IMPORT_ERROR=1
export WANDB_DISABLED=True

#alan
# dataset_path=/nfs/kun2/users/mitsuhiko/d4rl-pkl-dataset/data


#  conda activate /home/user/.conda/envs/odt && cd /work/online-dt

if [[ $HOSTNAME == ea81e6bd8557 ]]; then
    export MUJOCO_PY_MUJOCO_PATH=/work/.mujoco/mujoco210
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/work/.mujoco/mujoco210/bin
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/nvidia
    export MUJOCO_PY_MJKEY_PATH=/work/.mujoco/mjkey.txt
    export PYTHONPATH=:/work/online-dt
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/conda/lib
    export LD_LIBRARY_PATH=/home/user/.conda/envs/odt/lib:$LD_LIBRARY_PATH
else
    echo not docker!
fi



# dataset_path=/global/scratch/users/nakamoto/data
project_name=odt-antmaze


# env=antmaze-medium-diverse-v2
# env=antmaze-medium-play-v2
env=antmaze-large-play-v2
# env=antmaze-large-diverse-v2

# for seed in 2 4
for seed in 3 5
do
python main.py \
--num_updates_per_pretrain_iter=7000 \
--max_env_steps=1000000 \
--env=$env \
--embed_dim=1024 \
--eval_interval=10 \
--num_eval_episodes=50 \
--eval_context_length=5 \
--ordering=1 \
--eval_rtg=1 \
--online_rtg=2 \
--replay_size=1500 \
--learning_rate=0.001 \
--weight_decay=0 \
--seed=$seed \
--project=$project_name 
# --dataset_path=$dataset_path
done


# --save_dir=