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
    # - create PCB using init_params
    # - link PCB to Creation_Tree
    # - insert PCB to tail of Ready List i.e. insert(RL, PCB)
    # - Scheduler(); -> this finds the highest priority process in the RL and makes it running and others ready/blocked
  end

  def destroy(pid)
    # - get PCB p given pid
    # - Kill_tree(p)
    # - Scheduler();
  end

  def request(rid, number_of_units)
    # r = get_RCB(rid)
    # if r.count >= number_of_units
    #   r.count -= number_of_units
    #   self.other_resources.insert(r, n)
    # else
    #   self.status_type = :blocked
    #   self.status_list = r;
    #   Ready_List.remove(self)
    #   r.Waiting_List.insert(self)
    # Scheduler();
  end

  def release(rid)
    # r = get_RCB(rid)
    # self.other_resource.remove(r, n)
    # r.count += n
    # q = r.waiting_list.first
    # while q.not_empty? && r.count > q.requested_number_of_units
    #   r.count -= q.first.requested_number_of_units
    #   r.waiting_list.remove(q)
    #   q.status_type = :ready
    #   q.status_list = Ready_List
    #   q.other_resources.insert(r,n)
    #   Ready_List.insert(q)
    #   Scheduler();
  end

  def time_out
    # - find running process q
    # - Ready_List.remove(q)
    # - q.status_type = :ready
    # - Ready_List.insert(q)
    # - Scheduler();
  end

  def scheduler
    # - find highest priority process p
    # if self.priority < p.priority || self.status_type != :running || self == nil
    #   preempt(p,self)

    # preempt(p, self):
    #   p.status_type = :running
    #   output name of running process

    # Note: in the conditional,
    # - 1st condition is called from create or destroy
    # - 2nd condition is from request or time out
    # - 3rd condition from destroy
  end

  # Printer methods
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

  # Helper methods
  def kill_tree(p)
    # - for all p.children q, kill_tree(q)
    # - free resources
    # - delete PCB and update all pointers
  end
end