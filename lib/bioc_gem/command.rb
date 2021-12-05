require "erb"
require "fileutils"
require "tmpdir"
require_relative "parser"

module BiocGem
  class Command
    attr_accessor :parser

    def initialize(argv = ARGV)
      @argv = argv
    end

    def run
      parser.parse_options(@argv)

      config = parser.options.to_h

      target = config[:bioc_package_name]

      base = File.expand_path("../template/newgem", __dir__)

      Dir.mktmpdir do |tmpdir|
        Dir.glob("**/*", File::FNM_DOTMATCH, base: base) do |f|
          src = File.expand_path(f, base)
          next unless File.file?(src)

          warn src

          str = File.read(src)
          erb = ERB.new(str)
          str = erb.result(binding)

          trg = File.expand_path(f, tmpdir)
          fname = File.basename(trg, ".tt")
          fname.gsub!("new_gem_entry", config[:gem_require_name])
          dirname = File.dirname(trg)
          FileUtils.mkdir_p(dirname)
          File.write(File.join(dirname, fname), str)
        end
        FileUtils.cp_r(tmpdir, target)
      end
    end
  end
end
