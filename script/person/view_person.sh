#!/bin/bash
source /home/pljh0906/anaconda3/etc/profile.d/conda.sh
conda activate nerfstudio

LOG_DIR="logs"
mkdir -p $LOG_DIR
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_FILE="$LOG_DIR/view_${TIMESTAMP}.log"

LATEST_CONFIG=$(ls -td outputs/person-small/in2n/*/config.yml | head -1)

ns-viewer --load-config ${LATEST_CONFIG} \
    --viewer.websocket-port 7007 --viewer.websocket-host 0.0.0.0 --viewer.make-share-url True