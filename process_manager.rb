#!/usr/bin/env ruby
load 'process.rb'
load 'resource.rb'
load 'ready_list.rb'

class ProcessManager
  attr_accessor :resources

  def initialize()
    # Create Init process
    # Create ReadyList, add Init to ReadyList
    # Create Resources R1 - R4
    @resources = Resource.seed_resources
  end

  def create(init_params)
    # TODO
  end

  def destroy(pid)
    # TODO
  end

  def request(rid, number_of_units)
    # TODO
  end

  def release(rid)
    # TODO
  end

  def time_out
    # TODO
  end

  def scheduler
    # TODO
  end


end