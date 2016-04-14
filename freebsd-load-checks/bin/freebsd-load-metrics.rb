#! /usr/bin/env ruby
#  encoding: UTF-8
#   freebsd-load-metrics
#
# DESCRIPTION:
#   This plugin uses uptime to collect load metrics
#   Basically copied from sensu-community-plugins/plugins/system/vmstat-metrics.rb
#
#   Load per processor
#   ------------------
#
#   Optionally, with `--per-core`, this plugin will calculate load per
#   processor from the raw load average by dividing load average by the number
#   of processors.
#
#   The number of CPUs is determined by reading 'hw.ncpu' syctl oid. This makes the
#   feature FreeBSD specific. Other OSs can be supported by adding OS # detection
#   and a method to determine the number of CPUs.
#
# OUTPUT:
#   metric data
#
# PLATFORMS:
#   FreeBSD
#
# DEPENDENCIES:
#   gem: sensu-plugin
#   gem: socket
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

require 'sensu-plugin/metric/cli'
require 'socket'

if RUBY_VERSION < '1.9.0'
  require 'bigdecimal'

  class Float
    def round(val = 0)
      BigDecimal.new(to_s).round(val).to_f
    end
  end
end

class LoadStat < Sensu::Plugin::Metric::CLI::Graphite
  option :scheme,
         description: 'Metric naming scheme, text to prepend to .$parent.$child',
         long: '--scheme SCHEME',
         default: "#{Socket.gethostname}"

  option :per_core,
         description: 'Divide load average results by cpu/core count',
         short: '-p',
         long: '--per-core',
         boolean: true,
         default: false

  def number_of_cores
    @cores ||= %x( sysctl -n hw.ncpu ).to_i
  end

  def run
    result = `uptime`.gsub(',', '').split(' ')
    result = result[-3..-1]

    timestamp = Time.now.to_i
    if config[:per_core]
      metrics = {
        load_avg: {
          one: (result[0].to_f / number_of_cores).round(2),
          five: (result[1].to_f / number_of_cores).round(2),
          fifteen: (result[2].to_f / number_of_cores).round(2)
        }
      }
    else
      metrics = {
        load_avg: {
          one: result[0],
          five: result[1],
          fifteen: result[2]
        }
      }
    end

    metrics.each do |parent, children|
      children.each do |child, value|
        output [config[:scheme], parent, child].join('.'), value, timestamp
      end
    end
    ok
  end
end
