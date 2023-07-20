# About


## Python : Launch
This is an example repository that allows the user to allocate SLURM resources for a python script upon pushing the "Run and Debug" button.

Follow these steps to run the example script in this repository:

1. Make sure that your desired python file (e.g., `example.py`) is the file the is currently open in VS Code.

2. Navigate to the **Run and Debug** section on the sideby ![Alt text](/readme/run_and_debug.png)

3. Select a configuration from the dropdown menu. ![Alt text](/readme/configurations.png)

4. Hit the play button to run the file (or hit F5).

Now, two terminals will open: **Python Debug Console** and **startup**. Any errors encountered in your Python file will be logged to the **startup** console.

You should see this console hang for a bit; this is because the SLURM resources are being reserved. Then, you should see any text output (e.g., error logs) produced by your `.py` file. If an error is thrown by your Python script, you should see the following popup:
![Alt text](/readme/vscode_error.png)

Output of `example.py`:
![Alt text](/readme/console_output.png)


## Python : Attach
The `Python : Attach` debug task accomplishes the following

1. Runs the `launch-batch` prelaunch task (which runs `.vscode/launch-batch.sh`). This task will create a batch script and submit a batch job with `sbatch`. The batch script will activate a conda environment called `vscode` and then start `debugpy` to listen on `0.0.0.0:3000` from a compute node. The batch script is configured to hard-set the node that the job will run on ( here it is `rcclive-c260-sm-0`).

2. Once the batch job starts, the `launch-batch.sh` script will exit to return control back to the vscode attach command

3. VSCode will attach to the debugpy instance running at `rcclive-c260-sm-0:3000`

# Things that need to be cleaned up


## Python : Launch
- Remove dependency on `null.py` (probably by using attach process instead of of launch process)
- Get the debugger to actually work, instead of just logging errors to console

## Python : Attach
- Make the compute node configurable in the batch script creation process
- Make the python script to run configurable in the batch script creation process
- Cancel the Slurm job at the end of a debug session
