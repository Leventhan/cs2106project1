#!/usr/bin/env ruby

class ReadyList
  attr_accessor :processes

  def initialize
    @processes = [[],[],[]]
  end

  def insert(process, priority)
    if ![0,1,2].include? priority
      raise Exception.new("Invalid Priority value, must be either 0, 1, or 2")
    end
    @processes[priority].push process
  end

  def remove(process)
    @processes.each {|queue| queue.each {|p| queue.delete(p) if p.pid == process.pid }}
  end
end
