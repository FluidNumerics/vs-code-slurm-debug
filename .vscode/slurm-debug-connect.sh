
JOBNAME=$(cat vscode-slurm-jobid)
echo "Getting host for Slurm job $JOBNAME"

# Start TCP proxy from compute node
SLURM_COMPUTE_VM=$(squeue -u $USER --name=$JOBNAME --states=R -h -O NodeList | xargs)
echo "Starting TCP proxy from ${SLURM_COMPUTE_VM}:3000 to 127.0.0.1:$1"
echo "socat"
socat tcp-listen:$1,bind=127.0.0.1,forever,interval=10,fork tcp:${SLURM_COMPUTE_VM}:3000