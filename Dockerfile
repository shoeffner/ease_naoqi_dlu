FROM ease:naoqi

LABEL maintainer="Sebastian Höffner <shoeffner@tzi.de>"

# Copy workspace and initialize it
COPY catkin_ws/src /catkin_ws/src
RUN /ros_entrypoint.sh wstool update -t src \
    && /ros_entrypoint.sh rosdep update \
    && /ros_entrypoint.sh rosdep install -y --ignore-src --rosdistro ${ROS_DISTRO} --from-paths src/ \
    && /ros_entrypoint.sh catkin config --extend /opt/ros/${ROS_DISTRO} --cmake-args -DCMAKE_BUILD_TYPE=Release \
    && /ros_entrypoint.sh catkin build
