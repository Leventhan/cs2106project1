#!/usr/bin/env ruby
class Command
  def self.validate_commmand(c)
    unless c.start_with?("init") || c.start_with?("cr") || c.start_with?("de") || c.start_with?("req") || c.start_with?("rel") || c.start_with?("to")
      return false
      # raise Exception.new "Invalid command"
    end

    if c.start_with?("cr") || c.start_with?("rel") || c.start_with?("req")
      args = c.split(" ")
      unless args.size == 3
        return false
        # raise Exception.new "Invalid number of arguments"
      end

      begin
        !!Integer(args[2])
      rescue ArgumentError, TypeError
        return false
        # Last argument not a valid integer
      end
    end

    if c.start_with?("de")
      args = c.split(" ")
      unless args.size == 2
        return false
        # raise Exception.new "Invalid number of arguments"
      end
    end

    return true
  end

  def self.execute_command(c, pm)
    args = c.split(" ")
    command = args[0]
    case command
    when "cr"
      pm.create(args[1], Integer(args[2]))
    when "to"
      pm.time_out
    when "de"
      pm.destroy(args[1])
    when "req"
      pm.request(args[1], Integer(args[2]))
    when "rel"
      pm.release(args[1], Integer(args[2]))
    when "init"
      File.open("a0099317U.txt", 'a') { |file| file.write(pm.running_log.join(" ") + "\n\n") if pm.running_log.size > 1 }
    else
      raise Exception.new "Invalid command"
    end
  end


end