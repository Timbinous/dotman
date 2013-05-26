require 'fileutils'
require "dotman/version"
require "dotman/git"
module Dotman
  def self.ensure_dotman_folder_exists
    unless File.directory?("#{ENV['HOME']}/.dotman")
      FileUtils.mkdir("#{ENV['HOME']}/.dotman")
    end
  end
end
