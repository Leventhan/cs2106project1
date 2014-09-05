#!/usr/bin/env ruby
load 'process.rb'
load 'resource.rb'
load 'ready_list.rb'

class ProcessManager
  attr_accessor :resources, :ready_list

  def initialize()
    @ready_list = ReadyList.new # Create ReadyList + Add Init to ReadyList
    @resources = Resource.seed_resources # Create Resources R1 - R4
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

  # Helper methods
  def print_processes
    # TODO
  end

  def print_resources
    # TODO
  end

  def print_process(pid)
    # TODO
  end

  def print_resource(rid)
    # TODO
  end
end