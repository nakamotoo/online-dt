export CUDA_VISIBLE_DEVICES=1
export D4RL_SUPPRESS_IMPORT_ERROR=1
# export WANDB_DISABLED=True

env=antmaze-medium-diverse-v2

python main.py \
--num_updates_per_pretrain_iter=10 \
--max_env_steps=1000000 \
--env=$env \
--embed_dim=1024