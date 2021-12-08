require "erb"
require "fileutils"
require "tmpdir"
require_relative "parser"

module BiocGem
  class Command
    attr_accessor :parser

    def initialize(argv = ARGV)
      @argv = argv.clone
      @parser = Parser.new
    end

    def run
      parser.parse!(@argv)

      command = parser.command
      options = parser.options

      public_send("run_#{command}", options) if [:new].include?(command)
    end

    def run_new(options)
      config = parser.options
      require_name     = config.gem_require_name
      package_name     = config.bioc_package_name
      output_directory = config.output_directory

      target = File.join(output_directory, package_name)

      base = File.expand_path("../../template/newgem", __dir__)

      Dir.mktmpdir do |tmpdir|
        Dir.glob("**/*", File::FNM_DOTMATCH, base: base) do |f|
          src = File.expand_path(f, base)
          next unless File.file?(src)

          str = File.read(src)
          erb = ERB.new(str)
          str = erb.result(binding)

          trg = File.expand_path(f, tmpdir)
          fname = File.basename(trg, ".tt")
          fname.gsub!("new_gem_entry", config.gem_require_name)
          dirname = File.dirname(trg)
          FileUtils.mkdir_p(dirname)
          File.write(File.join(dirname, fname), str)
        end
        FileUtils.cp_r(tmpdir, target)
      end

      warn "Created #{target}"
    end
  end
end
