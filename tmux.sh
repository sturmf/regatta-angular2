#!/bin/bash
SESSION=$USER

tmux -2 new-session -d -s $SESSION

tmux new-window -t $SESSION:2 -n 'Django-Backend'
tmux new-window -t $SESSION:3 -n 'Angular2-Frontend'
tmux new-window -t $SESSION:4 -n 'Selenium-TestServer'
tmux new-window -t $SESSION:5 -n 'Protractor-End2EndTest'

tmux send-keys -t $SESSION:2 'cd backend'   ENTER 'make' ENTER
tmux send-keys -t $SESSION:3 'cd frontend'  ENTER 'make' ENTER
tmux send-keys -t $SESSION:4 'cd e2e_tests' ENTER 'make' ENTER

tmux send-keys -t $SESSION:5 'cd e2e_tests' ENTER 'make tests'

tmux attach
