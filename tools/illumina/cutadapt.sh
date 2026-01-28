
DIR=/projects/p_bp/tools/cutadapt/cutadapt-5.0
mkdir -p $DIR
python3 -m venv $DIR
source $DIR/bin/activate
pip install --upgrade pip
pip install cutadapt
deactivate
