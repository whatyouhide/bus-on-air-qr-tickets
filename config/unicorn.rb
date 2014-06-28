working_directory '/home/deploy/bus-on-air-qr-tickets_production/current'
pid '/home/deploy/bus-on-air-qr-tickets_production/shared/tmp/pids/unicorn.pid'
listen '/tmp/unicorn.qrtickets.sock'

worker_processes 2
timeout 15

stderr_path '/tmp/unicorn.log'
stdout_path '/tmp/unicorn.log'
