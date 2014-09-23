#!/usr/bin/env ruby
load 'process_manager.rb'
load 'command.rb'

# TODO: print running log instead of print running

File.open(ARGV[0], "r") do |infile|
    pm = ProcessManager.new
    while (line = infile.gets)
      next if line =="\r\n" || line =="\n"

      command = line.chomp
      is_valid = Command.validate_commmand(command)
      if is_valid
        Command.execute_command(command, pm)
      else
        pm.log_error
      end

      pm = ProcessManager.new if line.include? "init"
    end
    p pm.running_log.join " "
end