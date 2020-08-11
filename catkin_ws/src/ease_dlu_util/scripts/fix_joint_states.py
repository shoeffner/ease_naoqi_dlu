#!/usr/bin/env python
from functools import partial
import numpy as np

import rospy
from sensor_msgs.msg import JointState


def gather(values, mask):
    for value, valid in zip(values, mask):
        if valid:
            yield value


def bridge(publisher, message):
    vals = np.vstack((message.position,
                      message.velocity,
                      message.effort))
    # find NaN-columns
    nan_mask = np.isnan(vals)
    # collapse to one row which are not nan
    valid = ~np.any(nan_mask, axis=0)

    # filter all valid points
    message.name = list(gather(message.name, valid))
    message.position = list(gather(message.position, valid))
    message.velocity = list(gather(message.velocity, valid))
    message.effort = list(gather(message.effort, valid))

    publisher.publish(message)


def main():
    publisher = rospy.Publisher('joint_states/no_nan', JointState, queue_size=10)
    rospy.Subscriber('joint_states', JointState, partial(bridge, publisher))
    rospy.init_node('fix_joint_states', anonymous=True)
    rospy.spin()



if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        pass
