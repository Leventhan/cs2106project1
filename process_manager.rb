#!/usr/bin/env ruby

require 'debugger'
require 'awesome_print'
load 'process.rb'
load 'resource.rb'
load 'ready_list.rb'

class ProcessManager
  attr_accessor :resources, :ready_list

  def initialize()
    @ready_list = ReadyList.new # Create ReadyList + Add Init to ReadyList
    @resources = Resource.seed_resources # Create Resources R1 - R4
  end

  def create(pid, priority)
    p = Pprocess.new(pid, :ready, @ready_list, :ready, priority) #Set running as created process parent
    # - link PCB to Creation_Tree
    @ready_list.insert(p, priority)
    scheduler()
  end

  def destroy(pid)
    p = get_process(pid)
    kill_tree(p)
    scheduler()
  end

  def request(rid, number_of_units)
    r = get_resource(rid)
    running = @ready_list.find_running
    if r.units_current >= number_of_units
      r.units_current -= number_of_units
      running.other_resources.insert({r: number}) #TODO: standardize schema of process other_resources
    else
      running.status_type = :blocked
      running.status_list = r;
      @ready_list.remove(running)
      r.waiting_list.insert(running)
    end
    scheduler()
  end

  def release(rid)
    r = get_resource(rid)
    running = @ready_list.find_running
    running.other_resources.remove(r) #TODO: make sure this removes the dict with r key
    r.units_current += n #TODO: this n should refer to the n of the dict removed above
    q = r.waiting_list.first
    while q.not_empty? && r.units_current > q.requested_number_of_units #requested number of units refer to waiting list amount
      r.units_current -= q.first.requested_number_of_units
      r.waiting_list.remove(q)
      q.status_type = :ready
      q.status_list = @ready_list
      q.other_resources.insert(r,requested_number_of_units)
      Ready_List.insert(q)
    end
    scheduler()
  end

  def time_out
    p = @ready_list.find_running
    @ready_list.remove(p)
    p.status_type = :ready
    @ready_list.insert(p)
    scheduler()
  end

  def scheduler
    #  this finds the highest priority process in the RL and makes it running and others ready/blocked
    p = @ready_list.find_highest_priority
    running = @ready_list.find_running
    if running.priority < p.priority || running.status_type != :running || running == nil
      running.status_type = :ready# Make running process ready?
      preempt(p)
    end
  end

  def preempt(p)
    p.status_type = :running
    @ready_list.print_running
  end

  # Printer methods
  def print_processes
    ap @ready_list.processes
  end

  def print_resources
    ap @resources
  end

  def print_process(pid)
    ap get_process(pid)
  end

  def print_resource(rid)
    ap get_resource(rid)
  end

  # Helper methods
  def get_process(pid)
    @ready_list.find(pid)
  end

  def get_resource(rid)
    @resources[rid]
  end

  def kill_tree(p)
    #  Use rubytree gem
    # - for all p.children q, kill_tree(q)
    # - free resources
    # - delete PCB and update all pointers
  end
end