#!/bin/bash
source /home/pljh0906/anaconda3/etc/profile.d/conda.sh
conda activate nerfstudio

LOG_DIR="logs"
mkdir -p $LOG_DIR
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/training_${TIMESTAMP}.log"

LATEST_CONFIG=$(ls -td outputs/person-small/in2n/*/config.yml | head -1)

OUTPUT_DIR="renders/person"
mkdir -p ${OUTPUT_DIR}

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting nerfacto rendering..." | tee -a $LOG_FILE

ns-render dataset \
    --load-config ${LATEST_CONFIG} \
    --output-path ${OUTPUT_DIR}/person_dataset.mp4

ns-render dataset \
    --load-config ${LATEST_CONFIG} \
    --output-path ${OUTPUT_DIR}/person_dataset \
    --output-format images
          
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Completed nerfacto rendering" | tee -a $LOG_FILE