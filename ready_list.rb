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
    if ![0,1,2].include? priority
      raise Exception.new("Invalid Priority value, must be either 0, 1, or 2")
    end
    @processes[priority].push process
  end

  def remove(process)
    @processes.each {|queue| queue.each {|p| queue.delete(p) if p.pid == process.pid }}
  end
end
