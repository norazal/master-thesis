#!/bin/bash

#SBATCH -J "prokka_p2"
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
conda activate /gpfs/data/fs71579/diepn/prokka_env

cd /gpfs/data/fs71579/diepn/genomes/p2

for file in *.fna; do
    name="${file%.fna}"
    prokka --outdir ../prokka_p2/$name --prefix "$name" --centre X --compliant $file ;
done

