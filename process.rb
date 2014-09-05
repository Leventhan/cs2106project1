#!/usr/bin/env ruby

class Process
  attr_accessor :pid, :other_resources, :status_type, :status_list, :parent, :children, :priority

  def initialize()
    @other_resources = []
    @status_type = :ready
    @status_list = [] #TODO: ready list pointer
    @children = []
  end
end
