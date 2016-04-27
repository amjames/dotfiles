module purge 
module load intel 
module load mkl/11
module load gaussian
#module load python/2.7.2
#module load mvapich2
#echo "Modules loaded"
#echo "======================"
#module list 
#echo "======================"
#Stable python 2.7.9
PATH=/home/amjames2/installed/python/bin:$PATH
# personal cmake 
PATH=/home/amjames2/installed/cmake/bin:$PATH
# Stable PSI4
PATH=/home/amjames2/installed/psi4/bin:$PATH
# psi4 compiles with mpi enabled 
PATH=/home/amjames2/installed/mpi_psi/bin:$PATH
# scripts and such 
PATH=/home/amjames2/bin:$PATH
PATH=/home/amjames2/scripts/exe:$PATH
PATH=/home/amjames2/local/bin:$PATH


PYTHONPATH=/home/amjames2/installed/Python-Modules:$PYTHONPATH

source $GAUSSIAN_DIR/bsd/g09.profile
GAUSS_EXEDIR=/opt/apps/gaussian/09.A_02
export GAUSS_EXEDIR
GAUSS_SCRDIR=$SCRATCH
export GAUSS_SCRDIR

#aliases are helpful 
alias qstatme='qstat -u "amjames2"'
alias sst='showstart'
if [[ $- == *i* ]]; then
    qstatme;
fi    

