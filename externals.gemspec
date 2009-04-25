Gem::Specification.new do |s|
  s.name    = 'externals'
  s.version = '0.1.6'
  s.date    = '2008-03-12'
  
  s.summary     = "Work on git externals without affecting others"
  s.description = "Work on git externals without affecting others"
  
  s.author   = 'Winton Welsh'
  s.email    = 'mail@wintoni.us'
  s.homepage = 'http://github.com/winton/externals'
  
  s.executables = ["externals"]
  s.has_rdoc = false
  
  # = MANIFEST =
  s.files = %w[
    MIT-LICENSE
    README.markdown
    Rakefile
    bin/externals
    changelog.markdown
    externals.gemspec
    lib/externals.rb
    lib/externals/app.rb
    lib/externals/repository.rb
    lib/externals/yaml_config.rb
    spec/bin/externals_spec.rb
    spec/lib/app_spec.rb
    spec/lib/yaml_config_spec.rb
    spec/spec.opts
    spec/spec_helper.rb
  ]
  # = MANIFEST =
end