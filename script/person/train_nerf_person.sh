#!/bin/bash
source /home/pljh0906/anaconda3/etc/profile.d/conda.sh
conda activate nerfstudio

LOG_DIR="logs"
mkdir -p $LOG_DIR
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/rendering_${TIMESTAMP}.log"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting nerf training..." | tee -a $LOG_FILE
ns-train nerfacto --data datasets/person-small \
    --logging.steps-per-log 1000 \
    --vis tensorboard \
    2>&1 | tee -a $LOG_FILE
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Completed nerf training" | tee -a $LOG_FILE