#!/usr/bin/env ruby
load 'process.rb'

class ReadyList
  attr_accessor :processes

  def initialize
    @processes = [[],[],[]]
    init = Pprocess.new(0, :running, nil, self, 0)
    insert init, 0
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
