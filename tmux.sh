#!/bin/bash
SESSION=$USER

tmux -2 new-session -d -s $SESSION

tmux new-window -t $SESSION:1 -n 'Frontend-Angular2-Server'
tmux new-window -t $SESSION:2 -n 'Frontend-Static-Tests'
tmux new-window -t $SESSION:3 -n 'Frontend-Unit-Tests'
tmux new-window -t $SESSION:4 -n 'Frontend-Browser-Tests'
#tmux new-window -t $SESSION:5 -n 'Protractor-Webdriver'
#tmux new-window -t $SESSION:6 -n 'Protractor-End2EndTest'

tmux send-keys -t $SESSION:1 'cd frontend'  ENTER 'make' ENTER
tmux send-keys -t $SESSION:2 'cd frontend'  ENTER 'make lint && make style' ENTER
tmux send-keys -t $SESSION:3 'cd frontend'  ENTER 'make test' ENTER
tmux send-keys -t $SESSION:4 'cd frontend'  ENTER 'make dtests'
#tmux send-keys -t $SESSION:5 'cd e2e_tests' ENTER 'make' ENTER

#tmux send-keys -t $SESSION:6 'cd e2e_tests' ENTER 'make tests'

tmux attach
