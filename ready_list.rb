#!/usr/bin/env ruby
load 'process.rb'

class ReadyList
  attr_accessor :processes

  def initialize
    @processes = [[],[],[]]
    init = Pprocess.new("init", :running, self, 0) # Create and Add Init to ReadyList
    insert init
  end

  def find(pid)
    results = []
    @processes.each {|queue| queue.each {|p| results << p if p.pid == pid}}
    if results.any?
      return results[0]
    else
      raise Exception.new("Process with pid: #{pid} not found")
    end
  end

  def find_processes_of_type(status)
    running = []
    @processes.each {|queue| queue.each {|p| running << p if p.status_type == status}}
    return running
  end

  def find_running
    processes = find_processes_of_type(:running)
    if processes.any? && processes.length > 1
      raise Exception.new("More than one running process!")
    elsif processes.any? && processes.length == 1
      return processes[0]
    else
      nil
      # raise Exception.new("No currently running processes!")
    end
  end

  def find_highest_priority
    highest = @processes[2].first || @processes[0].first ||  @processes[1].first
    unless highest
      raise Exception.new("No highest priority process!")
    end
    return highest
  end

  def insert(process)
    if invalid_process? process
      raise Exception.new("Invalid Process")
    elsif invalid_priority? process.priority
      raise Exception.new("Invalid Priority value, must be either 0, 1, or 2")
    end
    @processes[process.priority].push process
  end

  # Removes processes of a given pid from an array of pids
  def remove_pids(pids)
    @processes.each {|queue| queue.each {|p| queue.delete(p) if  pids.include?(p.pid) }}
  end

  def remove(process)
    @processes.each {|queue| queue.each {|p| queue.delete(p) if p.pid == process.pid }}
  end

  def get_init_process
    @processes.first.select{|p| p.pid == "init"}.first
  end

  private
    def invalid_priority? priority
      ![0,1,2].include? priority
    end

    def invalid_process? process
      !process.is_a? Pprocess
    end
end
