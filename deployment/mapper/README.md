# Mapper Stage

This is to be used on the actual mapping device itself in order to start recording a mapping session. 

It simply records the messages published by the RGBD camera (and potentially other data sources) on several ROS topics into a ROSBag for playback by 
the subsequent stage, SLAM_Annotator. 

## Requirements
- Ubuntu 18.04
- ROS Melodic (ROS 1)
- Zed SDK 2.8.2, which requires:
	- CUDA 10.0
	- a CUDA-supported NVidia GPU with its drivers (proprietary)
- zed-ros-wrapper (ROS Node)
- tmux (terminal muxer)

## How to Use
Simply launch the associated bash script, `start_mapping.sh`, such as by executing the following command in a terminal window in this folder:
```
./start_mapping.sh
```

	
