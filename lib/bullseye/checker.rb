require 'xcodeproj'
require 'find'

module Bullseye
  class Checker
    include Xcodeproj::Project::Object

    def initialize(options = {})
      @target_name = options.fetch(:target)
      @project_path = options.fetch(:project)
      @excluded_directories = options.fetch(:exclude, [])
      @excluded_directories.collect! {|item| item.strip}
      @project_path = @project_path.gsub /\/$/, ''

      @project = Xcodeproj::Project.open @project_path
    end

    def begin
      ensure_inclusion
    end

    def ensure_inclusion
      names = source_names + resource_names
      names = names.map {|n| n.sub(/.*\/+/, "") }
      files = project_files
      files.delete_if { |file| names.include?(file) }

      files
    end

    def project_files
      file_names = []

      path_name = @project_path.gsub /(\w*\.\w*)$/, ''

      Find.find(path_name) do |path|
        @excluded_directories.each do |dir|
          if path.to_s.include? dir
            Find.prune
          end
        end
        file_names << strip_path_from_name(path) if path =~ /.*\.[xib|storyboard|m]$/
      end
      file_names
    end

    def target
      @target ||= @project.targets.select { |target| target.name == @target_name }.first
    end

    def resource_names
      names = target.resources_build_phase.files_references
      names.keep_if { |file| file.kind_of?(PBXFileReference) && !file.path.nil? && file.path =~ /[a-zA-Z0-9\-\_\~\/]*\.*[m|xib|storyboard]$/ }
      files = []
      names.each { |n| files << strip_path_from_name("#{n.path}") }
      files
    end

    def source_names
      references = target.source_build_phase.files_references
      references.keep_if do |r|
        r.kind_of?(PBXFileReference) && !r.path.nil?
      end
      files = []
      references.each { |r| files << strip_path_from_name("#{r.path}") }
      files
    end

    private

    def strip_path_from_name(name)
      name.gsub(/.*\/+/, "")
    end
  end
end
