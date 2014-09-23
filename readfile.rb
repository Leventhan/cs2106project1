#!/usr/bin/env ruby
load 'process_manager.rb'
load 'command.rb'

# TODO: print running log instead of print running

p = ProcessManager.new
File.open(ARGV[0], "r") do |infile|
    while (line = infile.gets)
      next if line.empty?
      command = line.chomp
      is_valid = Command.validate_commmand(command)
      if is_valid
        Command.execute_command(command, p)
      end
    end
    p p.running_log.join " "
end