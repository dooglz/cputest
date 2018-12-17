S=$(date +"%H_%M")
EXE=../../BUILD/cputest/Release/main.exe
#EXE=main
RUNS=2
TICKS=1000
./$EXE -a0 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS -s 0  | tee ${S}_CPUSEQ_${TICKS}_${RUNS}_0.csv                                                       
./$EXE -a1 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS -s 0  | tee ${S}_CPUOMP_${TICKS}_${RUNS}_0.csv                                                        
./$EXE -a1 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS -s 1  | tee ${S}_CPUOMP_${TICKS}_${RUNS}_1.csv
./$EXE -a1 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS -s 5  | tee ${S}_CPUOMP_${TICKS}_${RUNS}_5.csv                                                   
./$EXE -a1 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS -s 10 | tee ${S}_CPUOMP_${TICKS}_${RUNS}_10.csv                                                         
./$EXE -a1 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS -s 50 | tee ${S}_CPUOMP_${TICKS}_${RUNS}_50.csv                                                        
./$EXE -a1 -f $TICKS --bmin 0 --bmax 1000 --bs 100 -r $RUNS -s 100| tee ${S}_CPUOMP_${TICKS}_${RUNS}_100.csv

./$EXE -a0 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS -s 0  | tee ${S}_CPUSEQ_${TICKS}_${RUNS}_0.csv                                                       
./$EXE -a1 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS -s 0  | tee ${S}_CPUOMP_${TICKS}_${RUNS}_0.csv                                                        
./$EXE -a1 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS -s 1  | tee ${S}_CPUOMP_${TICKS}_${RUNS}_1.csv
./$EXE -a1 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS -s 5  | tee ${S}_CPUOMP_${TICKS}_${RUNS}_5.csv                                                   
./$EXE -a1 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS -s 10 | tee ${S}_CPUOMP_${TICKS}_${RUNS}_10.csv                                                         
./$EXE -a1 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS -s 50 | tee ${S}_CPUOMP_${TICKS}_${RUNS}_50.csv                                                        
./$EXE -a1 -f $TICKS --bmin 1000 --bmax 4000 --bs 100 -r $RUNS -s 100| tee ${S}_CPUOMP_${TICKS}_${RUNS}_100.csv

./$EXE -a0 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS -s 0  | tee ${S}_CPUSEQ_${TICKS}_${RUNS}_0.csv                                                             
./$EXE -a1 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS -s 0  | tee ${S}_CPUOMP_${TICKS}_${RUNS}_0.csv                                                        
./$EXE -a1 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS -s 1  | tee ${S}_CPUOMP_${TICKS}_${RUNS}_1.csv
./$EXE -a1 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS -s 5  | tee ${S}_CPUOMP_${TICKS}_${RUNS}_5.csv                                                   
./$EXE -a1 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS -s 10 | tee ${S}_CPUOMP_${TICKS}_${RUNS}_10.csv                                                         
./$EXE -a1 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS -s 50 | tee ${S}_CPUOMP_${TICKS}_${RUNS}_50.csv                                                        
./$EXE -a1 -f $TICKS --bmin 4000 --bmax 10000 --bs 100 -r $RUNS -s 100| tee ${S}_CPUOMP_${TICKS}_${RUNS}_100.csv