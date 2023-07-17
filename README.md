# About

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


# Things that need to be cleaned up

- Remove dependency on `null.py` (probably by using attach process instead of of launch process)

- Get the debugger to actually work, instead of just logging errors to console