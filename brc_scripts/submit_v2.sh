#!/bin/bash

# ENVS="door-v0;hammer-v0;pen-v0;relocate-v0"
# ENVS="door-v0;hammer-v0;pen-v0;relocate-v0;door-sparse-v0;hammer-sparse-v0;pen-sparse-v0;relocate-sparse-v0"

# ENVS="door-cxt-10-v0;hammer-cxt-10-v0;pen-cxt-10-v0;door-cxt-100-v0;hammer-cxt-100-v0;pen-cxt-100-v0;door-cxt-v0;hammer-cxt-v0;pen-cxt-v0"
# AS="1000000;2000000;5000000"

mkdir logs/out/ -p
mkdir logs/err/ -p

# arrENVS=(${ENVS//;/ })
# NUM_ENVS=${#arrENVS[@]}
# arrAS=(${AS//;/ })
# NUM_AS=${#arrAS[@]}

# echo $NUM_ENVS
# echo $NUM_AS

# let NUM_JOBS=$NUM_ENVS*$NUM_AS

sbatch --array=1-3%3 sbatch_v2.sh