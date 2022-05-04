#!/bin/bash
#SBATCH --job-name=bbnorm
#SBATCH --nodes=1
#SBATCH --cpus-per-task=36
#SBATCH --mem=180g
#SBATCH --time=120:00:00
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

#job.conf is a file that is a list of r1.fastq files
r1_path=$(sed "${arrayid}q;d" job.conf)

in_r1=$r1_path
in_r2=$(echo $r1_path | sed "s/R1/R2/")
out_r1=${in_r1%.fq}_norm.fq
out_r2=${in_r2%.fq}_norm.fq

singularity exec /nfs/turbo/lsa-dudelabs/containers/bbtools/bbtools.sif bbnorm.sh in=$in_r1 in2=$in_r2 out=$out_r1 out2=$out_r2 target=40 mindepth=2 prefilter=t threads=36
