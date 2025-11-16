#!/bin/bash

#SBATCH -J "checkm2_p3"
#SBATCH -N 1            # specified number of nodes - 1 node
#SBATCH --qos=skylake_0096          # use of skylake_0096
#SBATCH --partition=skylake_0096    # partition that fits to the qos

#SBATCH --ntasks-per-node=48
#SBATCH --ntasks-per-core=1
#SBATCH --time 48:00:00
#SBATCH --mail-type ALL
#SBATCH --mail-user norbert.diep@boku.ac.at

module purge
module load miniconda3

source ~/.bashrc
conda activate /gpfs/data/fs71579/diepn/checkm2_env

cd /gpfs/data/fs71579/diepn/genomes

checkm2 predict --threads 30 --input p3/* --output-directory checkm2_p3 --database_path /gpfs/data/fs71579/diepn/checkm2_database/uniref100.KO.1.dmnd --force

conda deactivate