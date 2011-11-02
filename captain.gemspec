Gem::Specification.new do |spec|

  spec.name = 'captain'
  spec.version = '0.1.6'
  spec.platform = Gem::Platform::RUBY
  spec.description = <<-DESC
    Hatimeria capistrano deployment.
  DESC
  spec.summary = <<-DESC.strip.gsub(/\n\s+/, " ")
    Hatimeria capistrano deployment.
  DESC

  spec.files = Dir.glob("{bin,lib}/**/*")
  spec.require_path = 'lib'
  spec.has_rdoc = false

  spec.bindir = "bin"
  spec.executables << "captain"

  spec.add_dependency 'capistrano', ">= 2.9.0"
  spec.add_dependency 'capistrano-ext', ">= 1.2.1"
  spec.add_dependency 'capifony', ">= 2.1.3"
  spec.add_dependency 'capigento', ">= 0.1.3"

  spec.author = "Witold Janusik"
  spec.email = "me@freakphp.com"
  spec.homepage = "http://hatimeria.com"

end
