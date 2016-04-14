#! /usr/bin/env ruby
#
#   freebsd-load-check
#
# DESCRIPTION:
#
# OUTPUT:
#   plain text
#
# PLATFORMS:
#   FreeBSD
#
# DEPENDENCIES:
#   gem: sensu-plugin
#
# USAGE:
#
# NOTES:
#
# LICENSE:
#   Copyright 2012 Sonian, Inc <chefs@sonian.net>
#   Copyright 2016 Vittorio Roberto Alfieri <me@rebtoor.com>
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#

# round(n) doesn't exist in ruby < 1.9
class Float
  alias_method :oldround, :round

  def round(precision = nil)
    if precision.nil?
      return self
    else
      return ((self * 10**precision).oldround.to_f) / (10**precision)
    end
  end
end

require 'sensu-plugin/check/cli'

class LoadAverage
  def initialize(per_core = false)
    @cores = per_core ? cpu_count : 1
    @avg = %x( sysctl -n vm.loadavg ).tr("{}","").split.map { |a| (a.to_f / @cores).round(2) } rescue nil # rubocop:disable RescueModifier
  end

  def cpu_count
    %x( sysctl -n hw.ncpu ).to_i rescue 0
  end   

  def failed?
    @avg.nil? || @cores.zero?
  end

  def exceed?(thresholds)
    @avg.zip(thresholds).any? { |a, t| a > t }
  end

  def to_s
    @avg.join(', ')
  end

end

class CheckLoad < Sensu::Plugin::Check::CLI
  option :warn,
         short: '-w L1,L5,L15',
         long: '--warn L1,L5,L15',
         description: 'Load WARNING threshold, 1/5/15 min average',
         proc: proc { |a| a.split(',').map(&:to_f) },
         default: [10, 20, 30]

  option :crit,
         short: '-c L1,L5,L15',
         long: '--crit L1,L5,L15',
         description: 'Load CRITICAL threshold, 1/5/15 min average',
         proc: proc { |a| a.split(',').map(&:to_f) },
         default: [25, 50, 75]

  option :per_core,
         short: '-p',
         long: '--per-core',
         description: 'Divide load average results by cpu/core count',
         boolean: 'true',
         default: false

  def run
    avg = LoadAverage.new(config[:per_core])
    warning 'Could not read load average from /proc' if avg.failed?
    message "Load average: #{avg}"
    critical if avg.exceed?(config[:crit])
    warning if avg.exceed?(config[:warn])
    ok
  end
end
