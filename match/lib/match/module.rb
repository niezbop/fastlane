require 'fastlane_core/helper'

module Match
  Helper = FastlaneCore::Helper # you gotta love Ruby: Helper.* should use the Helper class contained in FastlaneCore
  UI = FastlaneCore::UI
  ROOT = Pathname.new(File.expand_path('../../..', __FILE__))
  DESCRIPTION = "Easily sync your certificates and profiles across your team using git"

  def self.environments
    return %w(appstore adhoc development enterprise)
  end

  def self.distribution_types
    return %w(installer app)
  end

  def self.profile_type_sym(type)
    return type.to_sym
  end

  def self.cert_type_sym(type)
    return :enterprise if type == "enterprise"
    return :development if type == "development"
    return :distribution if ["adhoc", "appstore", "distribution"].include?(type)
    raise "Unknown cert type: '#{type}'"
  end

  def self.certs_dir(params, cert_type)
    File.join(params[:workspace], "certs", cert_type.to_s)
  end

  def self.profiles_dir(params, prov_type)
    File.join(params[:workspace], "profiles", prov_type.to_s)
  end

  # return the platform prefix under which to store the data
  def self.platform_dir(params)
    platform = ''
    platform = 'osx' if params[:platform].to_s == 'osx'
    platform
  end

  private_class_method :platform_dir
end
