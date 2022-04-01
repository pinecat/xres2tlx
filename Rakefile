# frozen_string_literal: true

require "bundler/gem_tasks"
require "standard/rake"

path = File.dirname(__FILE__)
bin = File.expand_path(path) + "/bin/xres2tlx"
lib = File.expand_path(path) + "/lib"

task default: :standard

task :run, [:filepath] do |t, args|
  sh "ruby -I#{lib} #{bin} #{args[:filepath]}"
end
