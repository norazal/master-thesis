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

while IFS=';' read -r col1 col2 _; do
 
 if ((skip_headers)) ;

 then ((skip_headers--)) ; continue ;
 
 else

  url="https://pubmlst.org/bigsdb?db=pubmlst_cronobacter_isolates&page=plugin&name=Contigs&format=text&isolate_id=$col2&match=1&pc_untagged=0&min_length=&header=1"
 
  #download fna-file from adapted url into temporary folder
  curl -o "./Temp_pm/$col2.fna" "$url" 
 
  for file in ./Temp_pm/* ; do

   mv -v -- "$file" "./Results_DL/$col1.fna" ; break ;

  done
 
  rm -rf ./Temp_pm/*

 fi

done < ./PubMLST_download_20240327.csv