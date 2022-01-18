if [[ ! -d $1 ]]; then
    echo "Directory $1 not exist"
    exit 9
fi

if [[ ! -f $1/lambda_function.py ]]; then
    echo "lambda_function.py not exist in $1"
    exit 9
fi
if [[ ! -f $1/requirement.txt ]]; then
    echo "requirement.txt not exist in $1"
    exit 9
fi

virtualenv $1
cd $1
source bin/activate
pip install -r requirement.txt
cd lib/python*/site-packages/
zip -r ../../../../$1.zip .
cd ../../../
zip -g ../$1.zip lambda_function.py
deactivate
