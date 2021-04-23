#!/bin/bash

# Exit immediately if a pipeline returns non-zero.
# Short form: set -e
set -o errexit

# Print a helpful message if a pipeline with non-zero exit code causes the
# script to exit as described above.
trap 'echo "Aborting due to errexit on line $LINENO. Exit code: $?" >&2' ERR

# Allow the above trap be inherited by all functions in the script.
# Short form: set -E
set -o errtrace

# Return value of a pipeline is the value of the last (rightmost) command to
# exit with a non-zero status, or zero if all commands in the pipeline exit
# successfully.
set -o pipefail

env=$1

UNIQUE=$(date +"%m_%d_%Y_H%H")
CATEGORIES="seo,performance"
 
# SHOULD COME FROM SITEMAP!!!
PROJECTS=[]
PROJECTS[0]="chivas.com/en-GB"
# PROJECTS[1]="chivas.com/el-GR"
# PROJECTS[2]="chivas.com/es-ES"

for PROJECT in "${PROJECTS[@]}"
do
    mkdir -p reports/$PROJECT/
    lighthouse https://www.$PROJECT?AvpPassThrough=1 --output=html --output-path=reports/$PROJECT/$UNIQUE.html --only-categories=$CATEGORIES --view
done 


