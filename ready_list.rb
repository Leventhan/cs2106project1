#!/usr/bin/env ruby
load 'process.rb'

class ReadyList
  attr_accessor :processes

  def initialize
    @processes = [[],[],[]]
    init = Pprocess.new(0, :running, nil, self, 0) # Create and Add Init to ReadyList
    insert init, 0
  end

  def find(pid)
    @processes.each {|queue| queue.each {|p| p.pid == pid ? p : nil}}
  end

  def find_running_processes
    running = []
    @processes.each {|queue| queue.each {|p| running << p if p.status_type == :running}}
    return running
  end

  def find_running
    processes = find_running_processes
    if processes.any?
      return processes[0]
    end
  end

  def print_running
    p find_running
  end

  def find_highest_priority
    @processes[0].first ||  @processes[1].first || @processes[2].first
  end

  def insert(process, priority)
    if invalid_priority? priority
      raise Exception.new("Invalid Priority value, must be either 0, 1, or 2")
    elsif invalid_process? process
      raise Exception.new("Invalid Process")
    end
    @processes[priority].push process
  end

  def remove(process)
    @processes.each {|queue| queue.each {|p| queue.delete(p) if p.pid == process.pid }}
  end

  private
    def invalid_priority? priority
      ![0,1,2].include? priority
    end

    def invalid_process? process
      !process.is_a? Pprocess
    end
end
