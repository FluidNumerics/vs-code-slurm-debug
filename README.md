# About
This repository contains a .vscode subdirectory with

* `settings.json` - A file for controlling the Slurm batch flags used to start your debug job and for setting the TCP port used to connect from the cluster login node to the Slurm compute node.
* `launch.json` - File that defines the debug launch configurations
* `tasks.json` - File that defines tasks, specifically those used for `preLaunchTasks` in the `launch.json`
* `launch-batch.sh` - Script that creates a batch script, submits a batch job to start a debugpy server on a compute node, and waits for the job to start before returning control back to VSCode
* `slurm-debug-connect.sh` - Script that sets up a TCP proxy connection between your `localhost:${config:SOCAT_PORT}` and the Slurm compute node's port 3000.

## Slurm-Python
This is an example repository that allows the user to allocate SLURM resources for a python script upon pushing the "Run and Debug" button. We are assuming that you are using the Python and Remote Explorer extensions and have a remote session in VSCode on a login node of an HPC cluster with the Slurm job scheduler.

Follow these steps to run the example script in this repository:

1. Edit the `.vscode/settings.json` file to set the `SLURM_SBATCH_FLAGS` to define the partition and other parameters for submitting the batch job for your debug session. Additionally, set the `SOCAT_PORT` to a port that other users on your cluster are not using.
2. Make sure that your desired python file (e.g., `example.py`) is the file the is currently open in VS Code.
3. Navigate to the **Run and Debug** section on the sideby ![Alt text](/readme/run_and_debug.png)
4. Select the `Slurm-Python` configuration .
5. Hit the play button to run the file (or hit F5).

Completing these steps will create a batch script and submit the batch job to the Slurm job scheduler. Once the job starts, the script will wait for the debugpy server on the compute node to start. Once the debugpy server starts, `socat` is used to set up a TCP proxy from the compute node (port 3000) to the login node of the cluster on the port set by `SOCAT_PORT` in `.vscode/settings.json`



# Things that need to be cleaned up

- [**Taking all requests! Open an issue!**](https://github.com/FluidNumerics/vs-code-slurm-debug/issues/new)
