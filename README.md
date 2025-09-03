# ibex-machine-learning-module-installation
This repository contains the steps to install the machine learning module on the Ibex HPC cluster.

# Pipeline Execution Steps

## 1. Connect to Ibex HPC
```
ssh username@glogn.ibex.kaust.edu.au
```

## 2. Clone this repository
```
git clone https://github.com/D-Barradas/ibex-machine-learning-module-installation.git
cd ibex-machine-learning-module-installation
```

## 3. Prepare and run the installation pipeline

### a. Run the setup script (for a fresh install)
This will set up all environment variables, create the target directory, run the installation, and generate the modulefile:
```
bash setup_install.sh
```
- This script will:
  - Export all required environment variables
  - Create the target directory for the environment
  - Set permissions
  - Copy and execute `run_install.sh` in the target directory
  - Generate the modulefile using the current configuration

### b. To rebuild or update the module
If you need to clean up and rebuild the module, use:
```
bash rebulid_module.sh
```
- This script will:
  - Clean up previous installations and logs
  - Re-run the installation and modulefile generation
  - Log all steps and errors to `rebuild_module.log`

## 4. To assing the default module 
Firts go to the following folder :
```
/sw/rl9g/modulefiles/applications/machine_learning
```

Modify the `.modulerc` file or create one, and should look like this

``` 
#%Module 1.0 -*- tcl -*-
module-version machine_learning/2024.01 default
```



<!-- ## 4. Load the module
After installation, load the module using the module system (adjust the path as needed):
```
module use /sw/rl9g/modulefiles/applications/machine_learning
module load machine_learning/<version>/<env_name>
``` -->

# Notes
- The machine learning module is only part of the rl9-gpu stack of modules.
- All logs for the rebuild process are saved in `rebuild_module.log`.
- You may need to adjust environment variables in the scripts for your specific version or environment.

# Authorship
- **Author:** Didier Barradas
- **Institution:** King Abdullah University of Science and Technology (KAUST)
- **Contact:** didier.barradas@kaust.edu.sa

