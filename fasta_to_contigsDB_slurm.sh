#!/bin/bash
#SBATCH --job-name=contigsdb
#SBATCH --nodes=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=16g
#SBATCH --time=10:00:00
#SBATCH --account=vdenef1
#SBATCH --partition=standard
#SBATCH --mail-user=jtevans@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --export=ALL
#SBATCH --array=1-167%10

#job.conf is a list of bin fastas
FASTA=$(sed -n "$SLURM_ARRAY_TASK_ID"p fastas.job.conf)
#genomes/ATCC29413.fa
GENOME_NAME=$(echo $FASTA | rev | cut -f1 -d "/" | rev | cut -f1 -d ".")
CONTIGS_DB=contigs_dbs/${GENOME_NAME}-CONTIGS.db
anvi-script-reformat-fasta $FASTA --simplify-names -o ${GENOME_NAME}-simp_names.fa -r contig_maps/${GENOME_NA
ME}-contig_map.txt
anvi-gen-contigs-database -f ${GENOME_NAME}-simp_names.fa \
                          -o $CONTIGS_DB --skip-mindful-splitting \
                          --project-name "$GENOME_NAME"
anvi-run-hmms -c $CONTIGS_DB -T 20
rm ${GENOME_NAME}-simp_names.fa
