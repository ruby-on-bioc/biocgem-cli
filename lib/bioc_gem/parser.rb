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

        parser.on("-o", "--output [DIR]", "Output directory") do |dir|
          options.output_directory = dir
        end
        parser.on("-n", "--bioc_package_name VAL", "e.g. org.Hs.eg.db") do |n|
          options.bioc_package_name = n
        end
        parser.on("-s", "--bioc_sqlite_database_name VAL", "e.g. org.Hs.eg.sqlite") do |db|
          options.bioc_sqlite_database_name = db
        end
        parser.on("--gem_icon [VAL]", "e.g. :family:") do |icon|
          options.gem_icon = icon
        end
        parser.on("--gem_constant_name [VAL]", "e.g. OrgHsEgDb") do |c|
          options.gem_constant_name = c
        end
        parser.on("--gem_require_name [VAL]", "e.g. org_hs_eg_db") do |rname|
          options.gem_require_name = rname
        end
        parser.on("-m", "--bioc_package_md5sum [VAL]", "check md5sum") do |md5|
          options.bioc_package_md5sum = md5
        end
        parser.on("--bioc_package_sha256sum [VAL]", "check sha256sum") do |sha256|
          options.bioc_package_sha256sum = sha256
        end
        parser.on("--bioc_version [VAL]", "e.g. 3.14") do |bv|
          options.bioc_version = bv
        end
        parser.on("-v", "--bioc_package_version VAL", "e.g. 3.14.0") do |v|
          options.bioc_package_version = v
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
