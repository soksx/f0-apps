#!/bin/bash
if [ -z "$1" ]; then
    echo "A tar file path must be provided as an argument."
    exit 1
fi
target_file="$1"

if [ -z "$2" ]; then
    echo "Target hardware version must be provided as an argument."
    exit 1
fi
target_hw="$2"

find_args=$(yq e -I=0 '.applications_user[] | keys| .[0]' applications_user.yml | awk '{print "-iname " $0 ".fap"}' ORS=' -o ' | sed -z 's/-o $//');
echo $find_args | xargs -I {} sh -c "find /opt/firmware/dist/${target_hw}-*/apps -type f \( {} \) -print0" | tar -czf $target_file --transform="s|^opt/firmware/dist/${target_hw}-\(.*\)/apps/||" --null -T -
