require "optparse"
require_relative "options"

module BiocGem
  class Parser
    attr_reader :command, :options

    def initialize(args = nil)
      @comand = nil

      @options = Options.new
      parse_options(args) if args
    end

    def parse!(args = ARGV)
      @command = args.shift&.to_sym
      if [:new].include?(command)
        public_send("parse_options_#{command}", args)
      else
        warn "Unknown command #{command}"
        nil
      end
    end

    def parse_options_new(args)
      opt_parser = OptionParser.new do |parser|
        parser.banner = "Usage: biocgem new [options]"

        parser.on("-n", "--bioc_package_name VAL", "e.g. org.Hs.eg.db") do |v|
          options[:bioc_package_name] = v
        end
        parser.on("-s", "--bioc_sqlite_database_name VAL", "e.g. org.Hs.eg.sqlite") do |v|
          options[:bioc_sqlite_database_name] = v
        end
        parser.on("--gem_icon [VAL]", "e.g. :family:") do |v|
          options[:gem_icon] = v
        end
        parser.on("--gem_constant_name [VAL]", "e.g. OrgHsEgDb") do |v|
          options[:gem_constant_name] = v
        end
        parser.on("--gem_require_name [VAL]", "e.g. org_hs_eg_db") do |v|
          options[:gem_require_name] = v
        end
        parser.on("--bioc_package_sha256sum [VAL]", "e.g. ") do |v|
          options[:bioc_package_sha256sum] = v
        end
        parser.on("--bioc_version [VAL]", "e.g. 3.14") do |v|
          options[:bioc_version] = v
        end
        parser.on("-v", "--bioc_package_version VAL", "e.g. 3.14.0") do |v|
          options[:bioc_package_version] = v
        end
      end

      opt_parser.parse!(args)

      options.gem_icon ||= ":notes:"
      options.gem_constant_name ||= \
        options.bioc_package_name
               .split(".").map(&:capitalize).join
      options.gem_require_name.nil?
      options.gem_require_name ||= \
        options.bioc_package_name
               .split(".").map(&:downcase).join("_")
      options.bioc_version ||= "release"

      options
    end
  end
end
