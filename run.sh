# export CUDA_VISIBLE_DEVICES=7
export D4RL_SUPPRESS_IMPORT_ERROR=1
# export WANDB_DISABLED=True

#alan
# dataset_path=/nfs/kun2/users/mitsuhiko/d4rl-pkl-dataset/data

dataset_path=/global/scratch/users/nakamoto/data
project_name=odt-antmaze

# env=antmaze-medium-diverse-v2
# env=antmaze-medium-play-v2
# env=antmaze-large-play-v2
env=antmaze-large-diverse-v2

for seed in 42 43 44
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
--project=$project_name \
--dataset_path=$dataset_path

done


# --save_dir=