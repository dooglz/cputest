# CPUSEQ
./../../BUILD/cputest/Release/main.exe -a0 --bmin 0 --bmax 10000 --bs 100 -r 2 -s 0 | tee CPUSEQ.csv
# CPUOMP                                                                    
./../../BUILD/cputest/Release/main.exe -a0 --bmin 0 --bmax 10000 --bs 100 -r 2 -s 0 | tee CPUOMP.csv                                                        
./../../BUILD/cputest/Release/main.exe -a0 --bmin 0 --bmax 10000 --bs 100 -r 2 -s 1 | tee CPUOMP_s1.csv
./../../BUILD/cputest/Release/main.exe -a0 --bmin 0 --bmax 10000 --bs 100 -r 2 -s 5 | tee CPUOMP_s5.csv                                                   
./../../BUILD/cputest/Release/main.exe -a0 --bmin 0 --bmax 10000 --bs 100 -r 2 -s 10 | tee CPUOMP_s10.csv                                                         
./../../BUILD/cputest/Release/main.exe -a0 --bmin 0 --bmax 10000 --bs 100 -r 2 -s 50 | tee CPUOMP_s50.csv                                                        
./../../BUILD/cputest/Release/main.exe -a0 --bmin 0 --bmax 10000 --bs 100 -r 2 -s 100| tee CPUOMP_s100.csv