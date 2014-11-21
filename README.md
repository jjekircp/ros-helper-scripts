ros-helper-scripts
==================

* rosremote.sh: automatically set ROS_MASTER_URI and ROS_IP shell variables for using a ROS master located on a different host.
   * Usage: `. rosremote.sh ROS_MASTER_IP`
   * (don't forget the "." or the variable setting will not take effect)
* ws: run a command in all subdirectories of your catkin workspace src/ directory
   * Usage: ws COMMAND
   * (I do things like ws git branch or ws git status to see the state of all my repositories at once) 
* netSearch.py: search selected segments of the local network for ROS Master, present to user, and offer use of rosremote.sh
   * Usage: netSearch.py 192.168.1.*
   * Placing the * symbol will search that entire subnet address, from 0-255
