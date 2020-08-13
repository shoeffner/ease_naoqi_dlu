wstool update -t src
rosdep update
rosdep install -y --ignore-src --rosdistro ${ROS_DISTRO} --from-paths src/
catkin config --extend /opt/ros/${ROS_DISTRO} --cmake-args -DCMAKE_BUILD_TYPE=Release
catkin build
