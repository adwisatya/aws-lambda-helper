# AWS Lamda Zip Generator
This script help developer to create zip file containing lambda_function with its external library that need to be included.

## Project Folder Structure
No automation without convention. Please follow this structure to use this generator.
/
- lambda_function.py
- requirement.txt

Any external library that need to be imported must be written in requirement.txt

## How to Use
````bash
bash zip_generator.sh {folder_name}
````
It will create zip with name {folder_name}.zip based on {folder_name}

## Supported Language
For now, only python runtime supported. Another runtime support will be added later.
