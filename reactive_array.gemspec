Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.summary = "Reactive Array."
  s.name = 'reactive_array'
  s.version = 1.2
  s.authors = ["Tijn Schuurmans"]
  s.email = %q{tijn.schuurmans@gmail.com}
  s.homepage = 'https://github.com/tijn/reactive_array'
  s.licenses = ['MIT']
  s.requirements << 'none'
  s.require_path = 'lib'
  s.files = ["lib/reactive_array.rb", "lib/serializing_array.rb"]
  s.description = "Reactive Array is a array that autoserializes itself after each write operation."
end
