# vim: tw=79 sts=2 ts=2 et foldmethod=marker foldmarker={{{,}}} ft=sh:
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

#tba
#PYTHONPATH=/home/amjames2/installed/Python-Modules:$PYTHONPATH

source $GAUSSIAN_DIR/bsd/g09.profile
GAUSS_EXEDIR=/opt/apps/gaussian/09.A_02
export GAUSS_EXEDIR
GAUSS_SCRDIR=$SCRATCH
export GAUSS_SCRDIR
