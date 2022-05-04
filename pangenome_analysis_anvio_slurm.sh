#!/bin/bash
#SBATCH --job-name=anvi-pangenome
#SBATCH --nodes=1
#SBATCH --cpus-per-task=36
#SBATCH --mem=180g
#SBATCH --time=24:00:00
#SBATCH --account=vdenef1
#SBATCH --partition=standard
#SBATCH --mail-user=jtevans@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --export=ALL
#  Show list of CPUs you ran on, if you're running under PBS
echo $SLURM_JOB_NODELIST
#  Change to the directory you submitted from
if [ -n "$SLURM_SUBMIT_DIR" ]; then cd $SLURM_SUBMIT_DIR; fi
pwd
module load Bioinformatics prodigal anvio hmmer ncbi-blast mcl 
#anvi-gen-genomes-storage -e contigs_db_paths.txt \
#                         -o All_Microcystis_with_missing-GENOMES.db
anvi-pan-genome -g All_Microcystis_with_missing-GENOMES.db \
                --project-name "Microcystis_Pangenome_with_outgroups" \
                --output-dir Microcystis_Pangenome_Anvio_with_outgroups_no_singletons_full_genes_added_missin
g \
                --num-threads 36 \
                --minbit 0.5 \
                --mcl-inflation 10 \
                --exclude-partial-gene-calls
