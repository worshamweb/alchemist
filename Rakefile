require 'rubygems'
require 'rake'
require 'bundler/setup'

require 'rspec/core/rake_task'
require 'rake/rdoctask'
require 'yaml'

RSpec::Core::RakeTask.new(:spec)

task :default => :test
task :test => [:spec]

PKG_FILES = %w(Rakefile) + Dir.glob("{lib}/**/*")

gem_spec = Gem::Specification.new do |spec|
  spec.name = 'alchemist'
  spec.version = '0.2.0'
  spec.summary = "Conversions...like you've never seen them before"
  spec.description = "Conversions...like you've never seen them before."
  spec.email = 'halogenandtoast@gmail.com'
  spec.homepage = 'http://github.com/halogenandtoast/alchemist'
  spec.authors = ['Matthew Mongeau']
  spec.files = PKG_FILES
end

desc "Generate gemspec"
task :gemspec do
  File.open("#{gem_spec.name}.gemspec", "w") do |f|
    f.write gem_spec.to_yaml
  end
end

desc "Generate documentation"
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title = 'Alchemist'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
