#!/bin/zsh
ACTION="bag"
OUT="$(dirname $0)/bags/"

while getopts :hlo: option
do
case "${option}"
in
h) ACTION='help';;
l) ACTION='live';;
o) OUT=${OPTARG};;
?) ACTION='help';;
esac
done

if [ "$ACTION" = "help" ]; then
	echo "Usage: $0 [-hl -o [directory]]"
	echo "\tNo Flags: Record Zed camera into rosbag"
	echo "\t-l: Record Zed Camera without rosbag (for live mapping)"
	echo "\t-o directory: outputs the rosbag into [directory], default is [script location]/bags/"
	exit 0
else
	if [ "$ACTION" = "bag" ]; then
		tmux new-session -d -s rosbagger
		tmux send-keys -t rosbagger "catsource" C-m
		tmux send-keys -t rosbagger "rosbag record --lz4 --chunksize=25600 --buffsize=102400 -o '$OUT' __name:=bagger /zed/zed_node/rgb/image_rect_color /zed/zed_node/rgb/camera_info /zed/zed_node/depth/camera_info /zed/zed_node/depth/depth_registered /zed/zed_node/odom /tf /tf_static" C-m
		echo "Now running rosbag node 'bagger' in tmux session rosbagger."
	fi
	tmux new-session -d -s zedmapper
	tmux send-keys -t zedmapper "catsource" C-m
	tmux send-keys -t zedmapper "roslaunch zed_wrapper zed.launch camera_model:=zed" C-m
	echo "Now running Zed_Wrapper in tmux session zedmapper."
	echo "\n Check tmux sessions via tmux attach-session -t (session name).\n List sessions via tmux ls."
fi
