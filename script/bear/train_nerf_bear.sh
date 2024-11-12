#!/bin/bash
source /home/pljh0906/anaconda3/etc/profile.d/conda.sh
conda activate nerfstudio

LOG_DIR="logs"
mkdir -p $LOG_DIR
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/rendering_${TIMESTAMP}.log"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting nerfacto training..." | tee -a $LOG_FILE
ns-train nerfacto --data datasets/bear \
    --logging.steps-per-log 1000 \
    --vis tensorboard \
    2>&1 | tee -a $LOG_FILE
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Completed nerfacto training" | tee -a $LOG_FILE

LATEST_OUTPUT=$(ls -td outputs/bear/nerfacto/*/ | head -1)

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting in2n training conversion..." | tee -a $LOG_FILE
ns-train in2n --data datasets/bear \
    --load-dir "${LATEST_OUTPUT}/nerfstudio_models" \
    --pipeline.prompt "Change the bear to a white dog" \
    --pipeline.guidance-scale 7.5 \
    --pipeline.image-guidance-scale 1.5 \
    --logging.steps-per-log 1000 \
    --vis tensorboard \
    2>&1 | tee -a $LOG_FILE