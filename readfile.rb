#!/usr/bin/env ruby
load 'process_manager.rb'

File.open(ARGV[0], "r") do |infile|
    while (line = infile.gets)


        p line



    end
end