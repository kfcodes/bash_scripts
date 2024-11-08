#!/bin/bash

# Session Name
SESSION="dev"
FASTAPI_DIR="$HOME/.fastapi"
FASTAPI_HOST="0.0.0.0"
FASTAPI_PORT=8000
REACT_DIR="$HOME/.reactapp"

# Check if the session already exists
tmux has-session -t $SESSION 2>/dev/null
if [ $? != 0 ]; then
    # Start a new session with the specified name
    tmux new-session -d -s $SESSION -n 'Running Applications'

    # Navigate to the FastAPI directory and start the FastAPI application
    tmux send-keys -t $SESSION:0 "cd $FASTAPI_DIR/app/" C-m
    tmux send-keys -t $SESSION:0 'source ../.venv/bin/activate' C-m
    tmux send-keys -t $SESSION:0 "uvicorn main:app --host $FASTAPI_HOST --port $FASTAPI_PORT --reload" C-m
    # Split the window vertically to create two panes
    tmux split-window -h -t $SESSION:0
    # In the new pane, navigate to the same directory
    tmux send-keys -t $SESSION:0.1 "cd $REACT_DIR" C-m
    tmux send-keys -t $SESSION:0.1 'npm start' C-m
    # Focus on the left pane (FastAPI)
    tmux select-pane -t 0

    # FastAPI backend
    tmux new-window -t $SESSION -n 'fastapi'
    tmux send-keys -t $SESSION:1 "cd $FASTAPI_DIR/app/" C-m
    tmux send-keys -t $SESSION:1 'source ../.venv/bin/activate' C-m

    # React app frontend
    tmux new-window -t $SESSION -n 'react'
    tmux send-keys -t $SESSION:2 "cd $REACT_DIR/src" C-m

    # Go back to React window
    tmux select-window -t $SESSION:0

fi

# Attach to the session
tmux attach -t $SESSION
