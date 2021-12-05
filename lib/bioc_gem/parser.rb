require "optparse"
require_relative "options"

module BiocGem
  class Parser
    attr_reader :command, :options

    def initialize
      @comand = nil

      @options = Options.new
    end

    def parse_options(args = ARGV)
      @command = args.shift&.to_sym

      return if @command != :new

      sample_config = {
        bioc_package_name: "org.Hs.eg.db",
        bioc_sqlite_database_name: "org.Hs.eg.sqlite",
        gem_icon: "🧑‍🤝‍🧑",
        gem_constant_name: "OrgHsEgDb",
        gem_require_name: "org_hs_eg_db",
        bioc_package_sha256sum: "d22c7e6b13f89488d10bafbf7eacdb6b7aaa697c131ed73f601a502ac86ecd56",
        bioc_version: "3.14",
        bioc_package_version: "3.14.0"
      }

      opt_parser = OptionParser.new do |parser|
        parser.banner = "Usage: biocgem [options]"

        sample_config.each do |key, value|
          parser.on("--#{key} VAL", "Set #{key} to VAL.", value.to_s) do |v|
            options[key] = v
          end
        end
      end

      opt_parser.parse!(args)

      options
    end
  end
end
