# Andrew M James 
# Bash setupfile for blueridge 
#
if [[ $- != *i* ]]; then
    updatrcs
fi    

 

#module purge 
#module load intel 
#module load mkl/11
##module load gaussian
##module load python/2.7.2
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


PYTHONPATH=/home/amjames2/installed/Python-Modules:$PYTHONPATH

#source $GAUSSIAN_DIR/bsd/g09.profile
#GAUSS_EXEDIR=/opt/apps/gaussian/09.A_02
#export GAUSS_EXEDIR
#GAUSS_SCRDIR=$SCRATCH
#export GAUSS_SCRDIR

#aliases are helpful 
alias qstatme='qstat -u "amjames2"'
alias vii='vi input.dat'
alias vio='vi output.dat'
alias tfo='tail -f output.dat'
alias peek='tail -f' 
alias la='ls -a'
alias alls='ls -al'
alias ll='ls -l'
alias sst='showstart'
alias his='history'
alias c='clear'
alias mpipsi='/home/akumar1/installed/parallel_psi4/bin/psi4'
##Greeting message 
#echo " "
#echo " "
#echo " " 
#echo " " 
#echo "TO DO:" 
#cat ~/.todo_lst 
#echo " " 
#echo " " 



