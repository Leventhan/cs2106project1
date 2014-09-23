    #!/usr/bin/env ruby

require 'awesome_print'
load 'process.rb'
load 'resource.rb'
load 'ready_list.rb'
load 'creation_tree.rb'

class ProcessManager
  attr_accessor :resources, :creation_tree, :ready_list, :running_log

  def initialize()
    @ready_list = ReadyList.new # Create ReadyList + Add Init to ReadyList
    @creation_tree = CreationTree.new(@ready_list.get_init_process) # Create creation tree with init as root
    @resources = Resource.seed_resources # Create Resources R1 - R4
    @running_log = []
    log_running
  end

  def create(pid, priority)
    running = @ready_list.find_running
    p = Pprocess.new(pid, :ready, @ready_list, priority)
    @creation_tree.insert(p, running)# - Add process p to Creation_Tree as child of currently running process
    @ready_list.insert(p)
    scheduler()
  end

  def destroy(pid)
    p = get_process(pid)
    if p
      kill_tree(p) #In Ready List
    else
      destroy_from_waiting_list(pid) #In Waiting List
    end
    scheduler()
  end

  def destroy_from_waiting_list(pid)
    @resources.each do |resource|
      resource.waiting_list.select!{|process|
        waiting_pid = process.first[0]
        waiting_pid != pid
      }
    end
  end

  def request(rid, number_of_units)
    r = get_resource(rid)
    running = @ready_list.find_running
    if r.units_current >= number_of_units
      r.units_current -= number_of_units
      running.other_resources[rid] = number_of_units # other_resources is a hash with format RID: units_used
    else
      running.status_type = :blocked
      running.status_list = r;
      @ready_list.remove(running)
      r.waiting_list << {running.pid => [number_of_units, running]} # waiting_list is an ordered list of hashes with format PID: [units_needed, process]
    end
    scheduler()
  end

  def release(rid, number_of_units)
    release_no_sched(rid, number_of_units)
    scheduler()
  end

  def release_no_sched(rid, number_of_units)
    r = get_resource(rid)
    running = @ready_list.find_running
    running.other_resources[rid] -= number_of_units
    running.other_resources.delete("rid") if (running.other_resources[rid] == 0) # Remove empty resource allocations
    r.units_current += number_of_units
    head = r.waiting_list.first # Q is a process blocked on the released resource
    if head
      requested_number_of_units = head.values[0][0]
      q = head.values[0][1]
    end
    while !head.nil? && r.units_current >= requested_number_of_units #requested number of units refer to waiting list amount
      r.units_current -= requested_number_of_units
      r.waiting_list.delete(head)
      q.status_type = :ready
      q.status_list = @ready_list
      q.other_resources[rid] = requested_number_of_units
      @ready_list.insert(q)
    end
  end

  def time_out
    p = @ready_list.find_running
    @ready_list.remove(p)
    @ready_list.insert(p)
    scheduler()
  end

  def scheduler
    p = @ready_list.find_highest_priority
    running = @ready_list.find_running
    if running == nil || running.priority < p.priority || p.status_type != :running
      running.status_type = :ready if running != nil
      preempt(p)
    end
    log_running
  end

  def preempt(p)
    p.status_type = :running
  end

  # Printer methods
  def log_running
    pid = @ready_list.find_running.pid
    @running_log << pid
  end

  def log_error
    @running_log << "error"
  end

  def print_ready_processes
    ap @ready_list.find_processes_of_type(:ready).map(&:pid)
  end

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
    index = rid[-1].to_i - 1 #HAX
    @resources[index]
  end

  def kill_tree(p)
    destroyed_pids = @creation_tree.destroy(p) #Removes processes from creation_tree
    release_resouces(destroyed_pids)
    @ready_list.remove_pids(destroyed_pids) #Removes processes from ready list
  end

  def release_resouces(pids)
    pids.each do |pid|
      process = @ready_list.find(pid)
      process.other_resources.each do |resource|
        rid, units = resource
        release_no_sched(rid, units)
      end
    end
  end

end