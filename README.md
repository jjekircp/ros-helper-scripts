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
* rosBWMonitor.sh: get the bandwidth usage and rate of all rostopics on a ros master. 
   * Usage:  ./rosBWMonitor.sh
   * Note: Should be run on whatever system would receive the data, for example a laptop on wifi.
   * To pipe to a CSV (for later analysis) use: ./rosBWMonitor.sh >> topics.csv
* Benchmark.bash : automatically installs dependacies and runs a simple benchmark to quickly get data about a computer
 

* Also of interest: 
  * Alias the rosdep command to ease use: 
  * alias rosdepquick="rosdep install --from-paths src --ignore-src --rosdistro=indigo -y"

   
