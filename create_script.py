import os

# List of common UVM components
uvm_components = ['test','env', 'agent', 'driver', 'monitor', 'scoreboard', 'coverage','sequencer', 'sequence']

# Directory to save the files
directory = "D:\C\Digital_Projects\FIR"


# Create files for each component
for component in uvm_components:
    file_name = f"FIR_{component}.sv"
    file_path = os.path.join(directory, file_name)
    
    with open(file_path, 'w') as file:
        file.write(f"// UVM {component.capitalize()} Component\n")
        file.write(f"`ifndef FIR_{component.upper()}_SV\n")
        file.write(f"`define FIR_{component.upper()}_SV\n\n")
        file.write(f"class FIR_{component} extends uvm_{component};\n")
        file.write(f"    `uvm_component_utils(FIR_{component})\n\n")
        file.write("    function new(string name, uvm_component parent);\n")
        file.write("        super.new(name, parent);\n")
        file.write("    endfunction\n\n")
        file.write("    // Add your component-specific code here\n\n")
        file.write("endclass\n\n")
        file.write(f"`endif // FIR_{component.upper()}_SV\n")

    print(f"Created file: {file_path}")
