#!/bin/sh
#SBATCH -J cputest
#SBATCH --array=0-4
#SBATCH --output=/share/40008190/cputest/out/newoutput.%J.%j.%a.%N.csv
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --exclusive

RUNS=2
TICKS=500
srun hostname
srun cp /share/40008190/cputest/main /home/40008190/cputest
srun -D /home/40008190 ./cputest -a0 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS --sleepT 0       | tee -a "/share/40008190/cputest/out/CPUSEQ_${TICKS}_${RUNS}_s000_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"
srun -D /home/40008190 ./cputest -a1 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS --sleepT 0       | tee -a "/share/40008190/cputest/out/CPUOMP_${TICKS}_${RUNS}_s000_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"
srun -D /home/40008190 ./cputest -a1 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS --sleepT 1       | tee -a "/share/40008190/cputest/out/CPUOMP_${TICKS}_${RUNS}_s001_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"
srun -D /home/40008190 ./cputest -a1 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS --sleepT 5       | tee -a "/share/40008190/cputest/out/CPUOMP_${TICKS}_${RUNS}_s005_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"
srun -D /home/40008190 ./cputest -a1 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS --sleepT 10      | tee -a "/share/40008190/cputest/out/CPUOMP_${TICKS}_${RUNS}_s010_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"
srun -D /home/40008190 ./cputest -a1 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS --sleepT 50      | tee -a "/share/40008190/cputest/out/CPUOMP_${TICKS}_${RUNS}_s050_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"
srun -D /home/40008190 ./cputest -a1 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS --sleepT 100     | tee -a "/share/40008190/cputest/out/CPUOMP_${TICKS}_${RUNS}_s100_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"

srun -D /home/40008190 ./cputest -a1 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS --sleepT 0    | tee -a "/share/40008190/cputest/out/CPUOMP_${TICKS}_${RUNS}_s000_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"
srun -D /home/40008190 ./cputest -a1 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS --sleepT 1    | tee -a "/share/40008190/cputest/out/CPUOMP_${TICKS}_${RUNS}_s001_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"
srun -D /home/40008190 ./cputest -a1 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS --sleepT 5    | tee -a "/share/40008190/cputest/out/CPUOMP_${TICKS}_${RUNS}_s005_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"
srun -D /home/40008190 ./cputest -a1 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS --sleepT 10   | tee -a "/share/40008190/cputest/out/CPUOMP_${TICKS}_${RUNS}_s010_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"
srun -D /home/40008190 ./cputest -a1 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS --sleepT 50   | tee -a "/share/40008190/cputest/out/CPUOMP_${TICKS}_${RUNS}_s050_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"
srun -D /home/40008190 ./cputest -a1 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS --sleepT 100  | tee -a "/share/40008190/cputest/out/CPUOMP_${TICKS}_${RUNS}_s100_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"
srun -D /home/40008190 ./cputest -a0 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS --sleepT 0    | tee -a "/share/40008190/cputest/out/CPUSEQ_${TICKS}_${RUNS}_s000_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"

srun -D /home/40008190 ./cputest -a1 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS --sleepT 0   | tee -a "/share/40008190/cputest/out/CPUOMP_${TICKS}_${RUNS}_s000_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"
srun -D /home/40008190 ./cputest -a1 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS --sleepT 1   | tee -a "/share/40008190/cputest/out/CPUOMP_${TICKS}_${RUNS}_s001_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"
srun -D /home/40008190 ./cputest -a1 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS --sleepT 5   | tee -a "/share/40008190/cputest/out/CPUOMP_${TICKS}_${RUNS}_s005_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"
srun -D /home/40008190 ./cputest -a1 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS --sleepT 10  | tee -a "/share/40008190/cputest/out/CPUOMP_${TICKS}_${RUNS}_s010_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"
srun -D /home/40008190 ./cputest -a1 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS --sleepT 50  | tee -a "/share/40008190/cputest/out/CPUOMP_${TICKS}_${RUNS}_s050_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"
srun -D /home/40008190 ./cputest -a1 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS --sleepT 100 | tee -a "/share/40008190/cputest/out/CPUOMP_${TICKS}_${RUNS}_s100_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"
srun -D /home/40008190 ./cputest -a0 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS --sleepT 0   | tee -a "/share/40008190/cputest/out/CPUSEQ_${TICKS}_${RUNS}_s000_${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}_${SLURMD_NODENAME}.csv"
