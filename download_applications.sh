#!/bin/bash
if [ -z "$1" ]; then
    echo "A route must be provided as an argument."
    exit 1
fi
target_dir="$1"

readarray applications_user < <(yq e -o=j -I=0 '.applications_user[]' applications_user.yml)

get_yml_value() {
    local application_yml=$1
    local selector=$2
    echo $(echo $application_yml | yq e "$selector" -);
}

for application in "${applications_user[@]}"; do
    app_name=$(get_yml_value "$application" 'keys | .[]')
    repo=$(get_yml_value "$application" ".$app_name.repo")
    branch=$(get_yml_value "$application" ".$app_name.branch")
    
    git clone --branch $branch $repo "$target_dir/$app_name"
done;