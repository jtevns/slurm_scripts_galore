#!/bin/bash
#SBATCH --job-name=anvio_annotate
#SBATCH --mail-user=jtevans@umich.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --cpus-per-task=1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=20
#SBATCH --mem-per-cpu=4g 
#SBATCH --time=24:00:00
#SBATCH --account=vdenef0
#SBATCH --partition=standard
#SBATCH --output=%x-%j.log
#SBATCH --array=1-183%183

# The application(s) to execute along with its input arguments and options:
db=$(sed -n "$SLURM_ARRAY_TASK_ID"p job.conf)
anvi-delete-hmms -c $db --hmm-source Ribosomal_RNAs
anvi-run-hmms -c $db -T 20  
anvi-run-ncbi-cogs -c $db --sensitive -T 20 --cog-data-dir /nfs/turbo/lsa-dudelabs/databases/anvio/cogs
anvi-run-pfams -c $db -T 20 --pfam-data-dir /nfs/turbo/lsa-dudelabs/databases/anvio/pfams
anvi-run-kegg-kofams -c $db -T 20 --kegg-data-dir /nfs/turbo/lsa-dudelabs/databases/anvio/kegg
