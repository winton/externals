require 'rake'

task :default => 'externals.gemspec'

file 'externals.gemspec' => FileList['{lib,spec}/**','Rakefile'] do |f|
  # read spec file and split out manifest section
  spec = File.read(f.name)
  parts = spec.split("  # = MANIFEST =\n")
  fail 'bad spec' if parts.length != 3
  # determine file list from git ls-files
  files = `git ls-files`.
    split("\n").
    sort.
    reject{ |file| file =~ /^\./ }.
    reject { |file| file =~ /^doc/ }.
    map{ |file| "    #{file}" }.
    join("\n")
  # piece file back together and write...
  parts[1] = "  s.files = %w[\n#{files}\n  ]\n"
  spec = parts.join("  # = MANIFEST =\n")
  File.open(f.name, 'w') { |io| io.write(spec) }
  puts "Updated #{f.name}"
end

# sudo rake install
task :install do
  `sudo gem uninstall externals -x`
  `gem build externals.gemspec`
  `sudo gem install externals*.gem`
  `rm externals*.gem`
end