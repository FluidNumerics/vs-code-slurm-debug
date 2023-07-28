#!/bin/bash

JOB=$RANDOM
TEMP_FILE="/tmp/vscode-sbatch-script.$JOB.slurm"

echo "Temporary job file: $TEMP_FILE" # show file name
echo "Current running file: $1" # show which script is being run

# Cancel job on Ctrl+C Keyboard Interrupt
JOBNAME="vscode-debug-$JOB"
trap "scancel -n $JOBNAME; exit 130" SIGINT

cat >$TEMP_FILE << EOL
#!/bin/bash
#SBATCH --job-name=$JOBNAME       
#SBATCH -o $JOBNAME.log                               
#SBATCH -e $JOBNAME.log  
#SBATCH --get-user-env  

python -m pip install debugpy
python -m debugpy --wait-for-client --listen 0.0.0.0:3000 ./$1

EOL
 
# display the job submission file
echo " ///////////////////////////////////////// "
echo "   Job submission file : $TEMP_FILE "
echo " ///////////////////////////////////////// "
cat $TEMP_FILE
echo " ///////////////////////////////////////// "

# submit the job
SLURM_SBATCH_FLAGS=$2
sbatch --get-user-env $SLURM_SBATCH_FLAGS $TEMP_FILE

echo 'Waiting for Slurm job to begin..'
while true; do
 export JOB_STATUS=$(squeue -n $JOBNAME --format="%.2t" | tail -n1 | xargs)
 echo "Job Status : $JOB_STATUS"
 if [ "$JOB_STATUS" == "R" ]; then
   echo "Job started!"
   break
 else
   sleep 2
   tput cuu 1
 fi
done

echo $JOBNAME > vscode-slurm-jobid

# Give the script some time to install and start debugpy server
sleep 15