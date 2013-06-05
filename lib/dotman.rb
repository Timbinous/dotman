require 'fileutils'
require "dotman/version"
require "dotman/base"
Dotman::Base.ensure_dotman_folder_exists
Dotman::Base.ensure_default_folder_exists
Dotman::Base.ensure_current_dotman_file_exists
require "dotman/git"
require "dotman/dotfile_collection"
require "dotman/user"
require "dotman/collect"
