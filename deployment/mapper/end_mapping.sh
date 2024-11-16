#!/bin/zsh
tmux ls &> /dev/null
if [ $? != 0 ]; then
	echo "No Tmux sessions to end."
	exit 1
fi


tmux has-session -t rosbagger $2>/dev/null
if [ $? = 0 ]; then
	rosnode kill /bagger
	tmux send-keys -t rosbagger "echo bananas" C-m
	tmux send-keys -t rosbagger "tmux kill-session" C-m
	echo "Bagging complete."
	echo "DON'T FORGET TO COPY THE BAG FOR USE."
fi

tmux has-session -t zedmapper $2>/dev/null
if [ $? = 0 ]; then
	rosnode kill /zed/zed_node
	tmux send-keys -t zedmapper "echo bagels" C-m
	tmux send-keys -t zedmapper "tmux kill-session" C-m
	echo "Mapping stopped."
fi
