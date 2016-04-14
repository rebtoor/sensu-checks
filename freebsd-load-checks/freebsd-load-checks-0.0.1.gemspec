# -*- encoding: utf-8 -*-
# stub: freebsd-load-checks 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "freebsd-load-checks".freeze
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "development_status" => "active", "maintainer" => "@mattyjones", "production_status" => "unstable - testing reccomended", "release_draft" => "false", "release_prerelease" => "false" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Vittorio Roberto Alfieri".freeze]
  s.date = "2016-04-14"
  s.description = "This plugin provides native load instrumentation\n
                   for monitoring and metrics collection, including:\n
                   load health, and total or per core metrics".freeze
  s.email = "<me@rebtoor.com>".freeze
  s.executables = [ "freebsd-load-check.rb".freeze, "freebsd-load-metrics.rb".freeze ]
  s.files = [ "bin/freebsd-load-check.rb".freeze, "bin/freebsd-load-metrics.rb".freeze ]
  s.homepage = "https://github.com/rebtoor/sensu-checks".freeze
  s.licenses = ["GPL".freeze]
  s.post_install_message = "You can use the embedded Ruby by setting EMBEDDED_RUBY=true in /etc/default/sensu".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3".freeze)
  s.rubygems_version = "2.6.3".freeze
  s.summary = "Sensu plugins for load check on FreeBSD systems".freeze

  s.installed_by_version = "2.6.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sensu-plugin>.freeze, ["= 1.2.0"])
      s.add_development_dependency(%q<codeclimate-test-reporter>.freeze, ["~> 0.4"])
      s.add_development_dependency(%q<rubocop>.freeze, ["= 0.32.1"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3.1"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<github-markup>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<redcarpet>.freeze, ["~> 3.2"])
      s.add_development_dependency(%q<yard>.freeze, ["~> 0.8"])
      s.add_development_dependency(%q<pry>.freeze, ["~> 0.10"])
    else
      s.add_dependency(%q<sensu-plugin>.freeze, ["= 1.2.0"])
      s.add_dependency(%q<codeclimate-test-reporter>.freeze, ["~> 0.4"])
      s.add_dependency(%q<rubocop>.freeze, ["= 0.32.1"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3.1"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<github-markup>.freeze, ["~> 1.3"])
      s.add_dependency(%q<redcarpet>.freeze, ["~> 3.2"])
      s.add_dependency(%q<yard>.freeze, ["~> 0.8"])
      s.add_dependency(%q<pry>.freeze, ["~> 0.10"])
    end
  else
    s.add_dependency(%q<sensu-plugin>.freeze, ["= 1.2.0"])
    s.add_dependency(%q<codeclimate-test-reporter>.freeze, ["~> 0.4"])
    s.add_dependency(%q<rubocop>.freeze, ["= 0.32.1"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.1"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.7"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<github-markup>.freeze, ["~> 1.3"])
    s.add_dependency(%q<redcarpet>.freeze, ["~> 3.2"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.8"])
    s.add_dependency(%q<pry>.freeze, ["~> 0.10"])
  end
end
