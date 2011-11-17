Gem::Specification.new do |s|
  s.name          = "asana"
  s.version       = "0.0.1"
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Rahul Trikha"]
  s.email         = ["rahul.trikha@gmail.com"]
  s.homepage      = "http://github.com/rahult/asanar"
  s.summary       = "Asana command line client"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency("mail", ["~> 2.3.0"])
  s.add_runtime_dependency("sendgrid", ["~> 1.0.1"])
  s.add_development_dependency("rspec", ["~> 2.5"])
end
