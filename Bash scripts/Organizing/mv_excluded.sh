#!/bin/bash

# heading into directory
cd /gpfs/data/fs71579/diepn/genomes

# determine paths
READ_FILE=("excluded_duplicates.tsv" "excluded_filtered.tsv")
SOURCES=("p1" "p2" "p3" "p4" "p5")
GOAL_DIR="excluded_genomes"

# creating goal directory
mkdir -p "$GOAL_DIR"

# loop, where every line will be read from first column
for TSV_FILE in "${READ_FILE[@]}"; do
    tail -n +2 "$TSV_FILE" | cut -f1 | while read -r BASE; do
        FILENAME="${BASE}.fna"
        for DIRECTORY in "${SOURCES[@]}"; do
            if [[ -f "$DIRECTORY/$FILENAME" ]]; then
                mv "$DIRECTORY/$FILENAME" "$GOAL_DIR/" 
                break
            fi
        done
    done
done