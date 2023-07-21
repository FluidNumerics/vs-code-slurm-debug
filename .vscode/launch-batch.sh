#!/bin/bash

JOB=$RANDOM
TEMP_FILE="/tmp/vscode-sbatch-script.$JOB.slurm"
 
echo "Temporary job file: $TEMP_FILE" # show file name
echo "Current running file: $1" # show which script is being run

# Cancel job on Ctrl+C Keyboard Interrupt
JOBNAME="vscode-$JOB"
trap "scancel -n $JOBNAME; exit 130" SIGINT

cat >$TEMP_FILE << EOL
#!/bin/bash
#SBATCH --nodelist=rcclive-c260-sm-0
#SBATCH --nodes=1
#SBATCH --exclusive
#SBATCH --job-name=$JOBNAME  
#SBATCH --time=1:00:00               
#SBATCH -o $JOBNAME.log                               
#SBATCH -e $JOBNAME.log  
#SBATCH --get-user-env  

source \${HOME}/.bashrc
conda activate vscode
python -m debugpy --wait-for-client --listen 0.0.0.0:3000 ./$1

EOL
 
# display the job submission
cat $TEMP_FILE

# submit the job
sbatch --get-user-env $TEMP_FILE

echo 'Waiting for Slurm job to begin..'
while true; do
 export JOB_STATUS=$(squeue -n $JOBNAME --format="%.2t" | tail -n1 | xargs)
 echo "Job Status : $JOB_STATUS"
 if [ "$JOB_STATUS" == "R" ]; then
   echo "Job started!"
   break
 else
   sleep 10
 fi
done

# echo "Waiting for pvserver to start..."
# while true; do
#   PV_STATUS=$(grep "Client connected." paraview-$JOB.log)
#   if [ "$PV_STATUS" = "Client connected." ]; then
#     echo "Paraview Server connected!"
#     break
#   else
#     echo "Waiting for pvserver to connect to client..."
#     sleep 5
#   fi
# done