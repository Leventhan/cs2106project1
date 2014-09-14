#!/usr/bin/env ruby
require 'tree'
load 'process.rb'

class CreationTree
  attr_accessor :root

  def initialize(init)
    @root = node(init)
  end

  def insert(child_process, parent_process)
    @root.each do |current_node|
      if current_node.content.pid == parent_process.pid
        current_node << node(child_process)
      end
    end
  end

  def destroy(process)
    # TODO: disallow destroying init process?
    destroyed_pids = []
    root_node.each { |node| destroyed_pids << node.content.pid }
    root_node.remove!(node(process))
    return destroyed_pids
  end

  def node(process)
    unless process.class == Pprocess
      raise Exception.new("Creation Tree Nodes must be a Process")
    end
    return Tree::TreeNode.new(process.pid, process)
  end

end