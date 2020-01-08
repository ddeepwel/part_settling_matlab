#!/bin/bash
# bash script for submitting a Matlab job to the sharcnet Graham queue

#SBATCH --ntasks=1              # number of processors
#SBATCH --mem-per-cpu=5G        # memory per processor (default in Mb)
#SBATCH --time=00-06:00:00      # time (DD-HH:MM:SS)
#SBATCH --job-name="matlab part_settling" # job name
#SBATCH --input=manypics.m     # Matlab script
##SBATCH --dependency=afterok:<jobid>       # Wait for job to complete (needs to be after --account)

#SBATCH --output=mat-%j.log                 # log file
#SBATCH --error=mat-%j.err                  # error file
#SBATCH --mail-user=ddeepwel@uwaterloo.ca   # who to email
#SBATCH --mail-type=FAIL                    # when to email
#SBATCH --account=def-mmstastn_cpu           # UW Fluids designated resource allocation

module load matlab/2019a
srun matlab -nodisplay -nosplash -singleCompThread
