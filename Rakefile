require 'rake'
require 'rdoc/task'
require 'rspec/core/rake_task'
require 'rubygems/package_task'

task default: :spec

namespace :test do
  desc 'Measures test coverage'
  task :coverage do
    rm_f "coverage"
    rm_f "coverage.data"
    rcov = "rcov --aggregate coverage.data --text-summary --exclude spec,^/"
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
  # rdoc.rdoc_files.include("app/**/*.rb")
  # rdoc.main = 'README'
end

spec = eval(File.read('reactive_array.gemspec'))
Gem::PackageTask.new(spec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
end
