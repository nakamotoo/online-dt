export CUDA_VISIBLE_DEVICES=1
export D4RL_SUPPRESS_IMPORT_ERROR=1
# export WANDB_DISABLED=True

#alan
# dataset_path=/nfs/kun2/users/mitsuhiko/d4rl-pkl-dataset/data

env=antmaze-medium-diverse-v2

python main.py \
--num_updates_per_pretrain_iter=10 \
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
--weight_decay=0



# --dataset_path=$dataset_path