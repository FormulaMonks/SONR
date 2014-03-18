# set path to app that will be used to configure unicorn,
# note the trailing slash in this example
@dir = ENV['OPENSHIFT_DATA_DIR'] + "unicorn/"
working_directory(ENV['OPENSHIFT_REPO_DIR'])
worker_processes 2

timeout 30

# Specify path to socket unicorn listens to,
# we will use this in our nginx.conf later
listen "#{@dir}sockets/unicorn.sock", :backlog => 64

# Set process id path
pid "#{@dir}pids/unicorn.pid"

# Set log file paths
stderr_path "#{@dir}log/unicorn.stderr.log"
stdout_path "#{@dir}log/unicorn.stdout.log"