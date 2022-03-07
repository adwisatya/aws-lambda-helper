#/bin/bash
check_folder_structure(){
    echo "Checking folder structure..."
    if [[ ! -d $1 ]]; then
        echo "Directory $1 not exist"
        exit 9
    fi
    echo "Directory $1 exist"
    if [[ ! -f $1/lambda_function.py ]]; then
        echo "lambda_function.py not exist in $1"
        exit 9
    fi
    echo "lambda_function.py exist in $1"
    if [[ ! -f $1/requirement.txt ]]; then
        echo "requirement.txt not exist in $1"
        exit 9
    fi
    echo "requirement.txt exist in $1"
}
include_all_requirements(){
    echo "Including all requirements"
    virtualenv $1
    cd $1
    source bin/activate
    pip install -r requirement.txt
    echo "Adding site-packages content to zip"
    cd lib/python*/site-packages/
    zip -r ../../../../$1.zip .
    cd ../../../
    for entry in `ls .`; do
        if [[ $entry != "lib" ]] && [[ $entry != "bin" ]]; then
            echo "Adding $entry to zip"
            zip -g ../$1.zip $entry
        fi
    done
    deactivate
}
generate_zip(){
    check_folder_structure $1
    include_all_requirements $1
}
case $1 in

    generate_zip)
    generate_zip $2
    ;;

    *)
    echo "=================================="
    echo "AWS Lambda Helper v0.1"
    echo "How to use:"
    echo ""
    echo "./aws-lambda-helper.sh generate_zip {folder_name} : generate deployable zip for lambda"
    ;;
esac