FROM ease:naoqi

LABEL maintainer="Sebastian Höffner <shoeffner@tzi.de>"

# Copy workspace and initialize it
COPY catkin_ws/src /catkin_ws/src
RUN /ros_entrypoint.sh wstool update -t src \
    && /ros_entrypoint.sh rosdep update \
    && /ros_entrypoint.sh rosdep install -y --ignore-src --from-paths src/ \
    && /ros_entrypoint.sh catkin_make \
    && /ros_entrypoint.sh catkin_make install
