require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

task :default => :test

Rake::TestTask.new(:test) do |t|
  ENV['TESTOPTS'] = '--runner=s'
  t.libs << 'lib'
  t.pattern = 'test/*_spec.rb'
  t.verbose = true
end

namespace :test do
  desc 'Measures test coverage'
  task :coverage do
    rm_f "coverage"
    rm_f "coverage.data"
    rcov = "rcov --aggregate coverage.data --text-summary --exclude test,^/"
    system("#{rcov} --html test/*_spec.rb")
  end
end

def flog(output, *directories)
  system("find #{directories.join(" ")} -name \\*.rb | xargs flog")
end

desc "Analyze code complexity."
task :flog do
  flog "lib", "lib"
end

desc "rdoc"
Rake::RDocTask.new('rdoc') do |rdoc|
    rdoc.rdoc_dir = 'doc'
    rdoc.title = 'Virginity vCard library'
    rdoc.options << '--line-numbers' << '--inline-source'
    #rdoc.rdoc_files.include("app/**/*.rb")
#     rdoc.main = 'README'
end

spec = eval(File.read('reactive_array.gemspec'))
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
end
