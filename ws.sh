#!/bin/bash -e


roscd () 
{ 
    local rosvals;
    if [[ $1 = "--help" ]] || [[ $# -gt 1 ]]; then
        echo -e "usage: roscd package\n\nJump to target package.";
        return 0;
    fi;
    if [ -z $1 ]; then
        if [ ! -z $ROS_WORKSPACE ]; then
            cd ${ROS_WORKSPACE};
            return 0;
        fi;
        if [ ! -z $CMAKE_PREFIX_PATH ]; then
            IFS=":" read -a workspaces <<< "$CMAKE_PREFIX_PATH";
            for ws in "${workspaces[@]}";
            do
                if [ -f $ws/.catkin ]; then
                    cd ${ws};
                    return 0;
                fi;
            done;
        fi;
        echo -e "Neither ROS_WORKSPACE is set nor a catkin workspace is listed in CMAKE_PREFIX_PATH.  Please set ROS_WORKSPACE or source a catkin workspace to use roscd with no arguments.";
        return 1;
    fi;
    _ros_decode_path $1 forceeval;
    if [ $? != 0 ]; then
        echo "roscd: No such package/stack '$1'";
        return 1;
    else
        if [ -z $rosvals ]; then
            if [ -z $ROS_WORKSPACE ]; then
                echo -e "No ROS_WORKSPACE set.  Please set ROS_WORKSPACE to use roscd with no arguments.";
                return 1;
            fi;
            cd ${ROS_WORKSPACE};
            return 0;
        else
            cd ${rosvals[1]}${rosvals[2]}${rosvals[3]};
            return 0;
        fi;
    fi
}


if [ "$#" -eq 0 ]; then exit; fi

roscd
cd ../src

for dir in $(find . -maxdepth 1 ! -path . -type d | xargs); do
  echo $dir
  pushd $dir >/dev/null
  $@
  popd >/dev/null
  echo ""
done
