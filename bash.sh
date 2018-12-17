S=$(date +"%H_%M")
EXE=../../BUILD/cputest/Release/main.exe
#EXE=main
RUNS=2
TICKS=500
./$EXE -a0 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS --sleepT 0   | tee ${S}_CPUSEQ_${TICKS}_${RUNS}_0.csv                                                       
./$EXE -a1 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS --sleepT 0   | tee ${S}_CPUOMP_${TICKS}_${RUNS}_0.csv                                                        
./$EXE -a1 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS --sleepT 1   | tee ${S}_CPUOMP_${TICKS}_${RUNS}_1.csv
./$EXE -a1 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS --sleepT 5   | tee ${S}_CPUOMP_${TICKS}_${RUNS}_5.csv                                                   
./$EXE -a1 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS --sleepT 10  | tee ${S}_CPUOMP_${TICKS}_${RUNS}_10.csv                                                         
./$EXE -a1 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS --sleepT 50  | tee ${S}_CPUOMP_${TICKS}_${RUNS}_50.csv                                                        
./$EXE -a1 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS --sleepT 100 | tee ${S}_CPUOMP_${TICKS}_${RUNS}_100.csv

./$EXE -a0 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS --sleepT 0   | tee ${S}_CPUSEQ_${TICKS}_${RUNS}_0.csv                                                       
./$EXE -a1 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS --sleepT 0   | tee ${S}_CPUOMP_${TICKS}_${RUNS}_0.csv                                                        
./$EXE -a1 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS --sleepT 1   | tee ${S}_CPUOMP_${TICKS}_${RUNS}_1.csv
./$EXE -a1 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS --sleepT 5   | tee ${S}_CPUOMP_${TICKS}_${RUNS}_5.csv                                                   
./$EXE -a1 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS --sleepT 10  | tee ${S}_CPUOMP_${TICKS}_${RUNS}_10.csv                                                         
./$EXE -a1 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS --sleepT 50  | tee ${S}_CPUOMP_${TICKS}_${RUNS}_50.csv                                                        
./$EXE -a1 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS --sleepT 100 | tee ${S}_CPUOMP_${TICKS}_${RUNS}_100.csv

./$EXE -a0 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS --sleepT 0   | tee ${S}_CPUSEQ_${TICKS}_${RUNS}_0.csv                                                             
./$EXE -a1 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS --sleepT 0   | tee ${S}_CPUOMP_${TICKS}_${RUNS}_0.csv                                                        
./$EXE -a1 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS --sleepT 1   | tee ${S}_CPUOMP_${TICKS}_${RUNS}_1.csv
./$EXE -a1 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS --sleepT 5   | tee ${S}_CPUOMP_${TICKS}_${RUNS}_5.csv                                                   
./$EXE -a1 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS --sleepT 10  | tee ${S}_CPUOMP_${TICKS}_${RUNS}_10.csv                                                         
./$EXE -a1 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS --sleepT 50  | tee ${S}_CPUOMP_${TICKS}_${RUNS}_50.csv                                                        
./$EXE -a1 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS --sleepT 100 | tee ${S}_CPUOMP_${TICKS}_${RUNS}_100.csv