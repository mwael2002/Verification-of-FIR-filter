import subprocess
import os

# Paths to the MATLAB executable and TCL interpreter
matlab_executable = 'matlab'  # Adjust this to the full path if not in PATH
tcl_interpreter = 'tclsh'  # Adjust this to the full path if not in PATH

# Paths to your MATLAB script and TCL script
matlab_script = 'script.m'  # Replace with your MATLAB script path
tcl_script = 'script.do'  # Replace with your TCL script path

# Ensure the scripts are executable
os.chmod(matlab_script, 0o755)
os.chmod(tcl_script, 0o755)

# Function to run MATLAB script
def run_matlab():
    process = subprocess.Popen([matlab_executable, '-batch', f"run('{matlab_script}')"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()
    if process.returncode != 0:
        print(f"MATLAB script failed with error:\n{stderr.decode()}")
    else:
        print(f"MATLAB script output:\n{stdout.decode()}")

# Function to run TCL script
def run_tcl():
    process = subprocess.Popen([tcl_interpreter, tcl_script], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()
    if process.returncode != 0:
        print(f"TCL script failed with error:\n{stderr.decode()}")
    else:
        print(f"TCL script output:\n{stdout.decode()}")

# Run both scripts in parallel
if __name__ == '__main__':
    from threading import Thread

    matlab_thread = Thread(target=run_matlab)
    tcl_thread = Thread(target=run_tcl)

    # Start both threads
    matlab_thread.start()
    tcl_thread.start()

    # Wait for both threads to complete
    matlab_thread.join()
    tcl_thread.join()

    print("Both scripts have completed execution.")
