#!/usr/bin/env ruby

class Resource
  attr_accessor :rid, :status_max, :status_current, :waiting_list

  def initialize(rid, status_max, status_current)
    @rid = rid
    @status_max = status_max
    @status_current = status_current
    @waiting_list = []
  end

  def self.seed_resources
    resources = []
    1..5.times do |count|
      resources << self.new(count, count, count)
    end
    return resources
  end
end