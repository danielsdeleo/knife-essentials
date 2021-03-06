require 'chef_fs/knife'
require 'chef_fs/command_line'

class Chef
  class Knife
    class Upload < ChefFS::Knife
      banner "knife upload PATTERNS"

      common_options

      option :recurse,
        :long => '--[no-]recurse',
        :boolean => true,
        :default => true,
        :description => "List directories recursively."

      option :purge,
        :long => '--[no-]purge',
        :boolean => true,
        :default => false,
        :description => "Delete matching local files and directories that do not exist remotely."

      option :force,
        :long => '--[no-]force',
        :boolean => true,
        :default => false,
        :description => "Force upload of files even if they match (quicker and harmless, but doesn't print out what it changed)"

      option :dry_run,
        :long => '--dry-run',
        :short => '-n',
        :boolean => true,
        :default => false,
        :description => "Don't take action, only print what would happen"

      def run
        patterns = pattern_args_from(name_args.length > 0 ? name_args : [ "" ])

        # Get the matches (recursively)
        patterns.each do |pattern|
          ChefFS::FileSystem.copy_to(pattern, local_fs, chef_fs, config[:recurse] ? nil : 1, config)
        end
      end
    end
  end
end

