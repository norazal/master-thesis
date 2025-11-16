#!/bin/bash

set -euo pipefail

# heading into directory
cd /gpfs/data/fs71579/diepn/genomes

# determining paths
BASE="/gpfs/data/fs71579/diepn/genomes/.."
GOAL="/gpfs/data/fs71579/diepn/genomes/gff_prokka"

# loop through prokka_p1 to prokka_p5
for i in {1..5}; do
    SOURCE="prokka_p$i"
    # check, whether directory exists
    if [[ -d "$SOURCE" ]]; then
        # find all .gff-files in all subdirectories and copy them
        find "$SOURCE" -mindepth 2 -maxdepth 2 -type f -name "*.gff" -print0 \
         | while IFS= read -r -d '' FILE; do
            cp "$FILE" "$GOAL";
        done
    fi
done


