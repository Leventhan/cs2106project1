#!/usr/bin/env ruby
require 'tree'
load 'process.rb'

class CreationTree
  attr_accessor :root

  def initialize(init)
    @root = node(init)
  end

  def print
    @root.print_tree
    return nil
  end

  def insert(child_process, parent_process)
    @root.each do |current_node|
      if current_node.content.pid == parent_process.pid
        current_node << node(child_process)
      end
    end
  end

  # Destroys nodes in the creation tree, returns a list of destroyed Pids
  def destroy(process)
    # TODO: disallow destroying init process?
    destroyed_pids = []
    process_node = get_node(process.pid)
    process_node.each { |node| destroyed_pids << node.content.pid }
    to_be_removed = get_node(process.pid)
    to_be_removed.parent.remove!(to_be_removed)
    return destroyed_pids
  end


  def get_node(pid)
    @root.each do |current_node|
      if current_node.content.pid == pid
        return current_node
      end
    end
  end

  def node(process)
    unless process.class == Pprocess
      raise Exception.new("Creation Tree Nodes must be a Process")
    end
    return Tree::TreeNode.new(process.pid, process)
  end

end