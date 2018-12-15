# CPUSEQ
./../../BUILD/cputest/Release/main.exe 25 100000 0 4 50 1 0 2>&1 | tee CPUSEQ.csv
# CPUOMP
./../../BUILD/cputest/Release/main.exe 25 100000 0 4 50 1 1 2>&1 | tee CPUOMP.csv