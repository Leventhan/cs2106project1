#!/usr/bin/env ruby

# This is not a typo, Process is a reserved keyword in Ruby
class Pprocess
  attr_accessor :pid, :other_resources, :status_type, :status_list, :parent, :children, :priority
  # STATUS_TYPE = [:running, :ready, :blocked] #TODO: validate status_type in this constant

  def initialize(pid, status_type, status_list, priority)
    @pid = pid
    @status_type = status_type
    @status_list = status_list
    @priority = priority
    @other_resources = {}
    @status_list = [] # Either Ready List or Blocked List
    # Parent and Children abstracted to creation_tree
  end
end
