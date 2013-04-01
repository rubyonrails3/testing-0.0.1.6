
root = "/home/deploy/app/current"
worker_processes 4
working_directory "/home/deploy/app/current" # available in 0.94.0+
listen "/tmp/unicorn.app.sock", :backlog => 64
listen 8082, :tcp_nopush => true
timeout 30
pid "/home/deploy/app/current/tmp/pids/unicorn.pid"
stderr_path "/home/deploy/app/current/log/unicorn.stderr.log"
stdout_path "/home/deploy/app/current/log/unicorn.stdout.log"
