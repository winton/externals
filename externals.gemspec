# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{externals}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Winton Welsh"]
  s.date = %q{2009-05-16}
  s.default_executable = %q{externals}
  s.email = %q{mail@wintoni.us}
  s.executables = ["externals"]
  s.extra_rdoc_files = ["README.markdown"]
  s.files = ["bin", "bin/externals", "externals.gemspec", "lib", "lib/externals", "lib/externals/app.rb", "lib/externals/repository.rb", "lib/externals/yaml_config.rb", "lib/externals.rb", "MIT-LICENSE", "Rakefile", "README.markdown", "spec", "spec/externals", "spec/externals/app_spec.rb", "spec/externals/repository_spec.rb", "spec/externals/yaml_config_spec.rb", "spec/spec.opts", "spec/spec_helper.rb"]
  s.homepage = %q{http://github.com/winton/externals}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Quickly freeze and unfreeze external git dependencies}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
