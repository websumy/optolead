# Set the working application directory
# working_directory "/path/to/your/app"
working_directory '/home/yarivo/www/optolead/current'

# Unicorn PID file location
# pid "/path/to/pids/unicorn.pid"
pid '/home/yarivo/www/optolead/current/tmp/pids/unicorn.pid'

# Path to logs
stderr_path '/home/yarivo/www/optolead/current/log/unicorn.log'
stdout_path '/home/yarivo/www/optolead/current/log/unicorn.log'

# Unicorn socket
#listen "/tmp/unicorn.[app name].sock"
listen '/tmp/unicorn.optolead.sock'

# Number of processes
# worker_processes 4
worker_processes 2

# Time-out
timeout 30

preload_app true