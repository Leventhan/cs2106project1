#!/usr/bin/env ruby
load 'process_manager.rb'

p = ProcessManager.new
p.create("x", 1)
p.create("p", 1)
p.create("q", 1)
p.create("r", 1)
p.time_out
p.request("R2", 1)
p.time_out
p.request("R3", 3)
p.time_out
p.request("R4", 3)
p.time_out
p.time_out
p.request("R3", 1)
p.request("R4", 2)
p.request("R2", 2)
p.time_out
p.destroy("q")
p.time_out
p.time_out
