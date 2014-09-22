#!/usr/bin/env ruby
load 'process_manager.rb'
load 'command.rb'

p = ProcessManager.new
File.open(ARGV[0], "r") do |infile|
    while (line = infile.gets)
      next if line.empty?
      # TODO: ignore empty line and test init case with test-GR sample

      command = line.chomp
      is_valid = Command.validate_commmand(command)
      if is_valid
        Command.execute_command(command, p)
      end
    end
end