#!/bin/bash

#SBATCH -J single
#SBATCH -n 1            # specified number of cores - 1 core
#SBATCH --mem=2G        # memory limit - 2 Gigabytes

#SBATCH --qos=skylake_0096          # use of skylake_0096
#SBATCH --partition=skylake_0096    # partition that fits to the qos

module purge

echo 'Hello from node: '$HOSTNAME
echo 'Number of nodes: '$SLURM_JOB_NUM_NODES
echo 'Tasks per node:  '$SLURM_TASKS_PER_NODE
echo 'Partitions used: '$SLURM_JOB_PARTITION
echo 'Using the nodes: '$SLURM_JOB_NODELIST

#
rm -rf ./Temp/*

skip_headers=1

while IFS=';' read -r col1 col2 _; do         # col1 = var1, column 1; col2 = var2, column 2
 
 if ((skip_headers)) ;

 then ((skip_headers--)) ; continue ;
 
 else

  url="https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/$col2/download?include_annotation_type=GENOME_FASTA"

  curl -o "./Temp/temp.zip" "$url" 

  unzip -d "./Temp/temp" ./Temp/temp.zip
 
  for file in ./Temp/temp/ncbi_dataset/data/$col2/* ; do

   echo "$file"

   mv -v -- "$file" "./Results_DL/$col1.fna" ; break ;

  done
 
  rm -rf ./Temp/*

 fi

done < ./NCBI_download_2025_02_03.csv
