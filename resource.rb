#!/usr/bin/env ruby
class Resource
  attr_accessor :rid, :units_max, :units_current, :waiting_list

  def initialize(rid, units_max, units_current)
    @rid = rid
    @units_max = units_max
    @units_current = units_current
    @waiting_list = []
  end

  def self.seed_resources
    resources = []
    4.times do |count|
      resources << self.new("R#{(count+1)}", count+1, count+1)
    end
    return resources
  end
end