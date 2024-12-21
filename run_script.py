import subprocess

def run_matlab_script(matlab_script_path,matlab_executable_path):
    """
    Runs a MATLAB script and waits for it to finish.
    
    Args:
        matlab_script_path (str): Path to the MATLAB script (without .m extension).
    
    Returns:
        str: Output from the MATLAB process.
    """
    try:
        # Command to run MATLAB
        command = [
            matlab_executable_path,
            "-wait",
            "-r",
            matlab_script_path
        ]
        
        # Run MATLAB and wait for it to finish
        process = subprocess.run(
            command,
            text=True,
            capture_output=True,
            shell=True
        )
        
        return process.returncode
    except Exception as e:
        print(f"Error running MATLAB script: {e}")
        return None

def run_questa_with_mpf(mpf_file_path, tcl_commands=None):
    """
    Runs QuestaSim project file (.mpf) and optionally executes TCL commands.
    
    Args:
        mpf_file_path (str): Path to the QuestaSim .mpf file.
        tcl_commands (list, optional): List of TCL commands to run after opening the project.
    
    Returns:
        str: Output from the QuestaSim process.
    """
    questasim_exe = "D:/A/questasim64_2021.1/win64/questasim.exe"  # Ensure `vsim` is in your system's PATH.
    tcl_script = "\n".join(tcl_commands) if tcl_commands else ""

    try:
        # Run QuestaSim with the .mpf file
        command = [
            questasim_exe,
            "-do",
            f"project open {mpf_file_path}; {tcl_script}"
        ]
        
        # Run QuestaSim and wait for it to finish
        process = subprocess.run(
            command,
            text=True,
            capture_output=True,
            shell=True
        )

        return process.returncode
    except Exception as e:
        print(f"Error running QuestaSim: {e}")
        return None


if __name__ == "__main__":
    # Full path to MATLAB executable
    matlab_executable = "D:/A/MathWorks_MATLAB_R2021a_v9.10.0.1602886/bin/matlab.exe"
    
    # Paths to files
    matlab_script = "cd 'D:\C\Digital_Projects\FIR'; Signal_Generation"  # MATLAB script without .m extension
    mpf_file = "D:/C/Digital_Projects/FIR/FIR.mpf"

    # TCL commands for QuestaSim
    tcl_commands = [
        "do run.do", 
    ]

    # Run MATLAB script
    print("Running MATLAB script...")
    matlab_result = run_matlab_script(matlab_script,matlab_executable)

    if matlab_result == 0:  # MATLAB script finished successfully
        print("MATLAB script completed. Running QuestaSim...")
        questa_result=run_questa_with_mpf(mpf_file, tcl_commands)
        
        if questa_result == 0:  # QuestaSim finished successfully
            print("QuestaSim completed. Running second MATLAB script...")
            matlab_script = "cd 'D:\C\Digital_Projects\FIR'; Generate_audio_dut"
            second_matlab_result = run_matlab_script(matlab_script, matlab_executable)
            
            if second_matlab_result == 0:
                print("Second MATLAB script completed successfully.")
            else:
                print("Second MATLAB script failed.")
        else:
            print("QuestaSim failed. Aborting second MATLAB script execution.")
    else:
        print("First MATLAB script failed. Aborting subsequent steps.")
