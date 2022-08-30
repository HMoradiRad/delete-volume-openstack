#!/bin/bash

echo -e "\n\nPlease select one of the values below\n\n"
echo -e "available\terror\tin-use"

volumetype=(available error in-use)
while [ 1==1 ]; do
    read -p "plese enter volume type : " input

    if [[ "${volumetype[*]}" =~ "${input}" ]]; then

        clear
        echo -e "\n\nPlease select one of the values below\n\n"
        echo "purge or delete or force"

        read -p "please enter type delete if empty set defualt ==> delete : " del
        deltype=("--purge" "--force")

        if [[ "${deltype[*]}" =~ "${del}" ]]; then

            available=($(openstack volume list | grep $input | cut -d '|' -f 2))
            for i in ${available[@]}; do

                openstack volume delete $del $i
                if [ $? -ne 0 ]; then
                    echo $i >>errorvolume
                    continue
                fi
                sleep 2
            done
        fi

        if [ $? -eq 0 ]; then
            break
        fi

        i=0
    else
        echo "lotfan meghdare sahih ra cared konid"
        ((i++))
        if [ $i -gt 2 ]; then
            break
        fi

    fi

done
