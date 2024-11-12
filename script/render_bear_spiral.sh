#!/bin/bash
source /home/pljh0906/anaconda3/etc/profile.d/conda.sh
conda activate nerfstudio

LOG_DIR="logs"
mkdir -p $LOG_DIR
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/training_${TIMESTAMP}.log"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting nerfacto rendering..." | tee -a $LOG_FILE
ns-render spiral \
    --load-config outputs/bear/in2n/2024-11-11_235032/config.yml \
    --output-path renders/bear_to_dog.mp4 \

ns-render spiral \
    --load-config outputs/bear/in2n/2024-11-11_235032/config.yml \
    --output-path renders/bear_to_dog \
    --output-format images \
          
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Completed nerfacto rendering" | tee -a $LOG_FILE