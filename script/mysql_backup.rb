#!/usr/bin/env ruby
# Copyright (c) 2009-2011 VMware, Inc.
#
# This script is used to backup mysql instances used in MyaaS.

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../../Gemfile", __FILE__)
$:.unshift File.join(File.dirname(__FILE__), '..', '..', 'base', 'lib')
require 'base/backup'

$:.unshift(File.expand_path("../../lib", __FILE__))
require 'mysql'

module VCAP
  module Services
    module Mysql
    end
  end
end
class VCAP::Services::Mysql::Backup < VCAP::Services::Base::Backup
  SYSTEM_DB = %w(mysql information_schema)
  IGNORE_DB = %w(test)

  def default_config_file
    File.join(File.dirname(__FILE__), '..', 'config', 'mysql_backup.yml')
  end

  def backup_db
    opts = {
      :service_name => @config["service_name"],
      :backup_cmd => @config["backup_cmd"],
      :host => @config["mysql"]["host"],
      :port => @config["mysql"]["port"],
      :user => @config["mysql"]["user"],
      :passwd => @config["mysql"]["pass"],
      :backup_path => @config["backup_base_dir"],
      :compress_cmd => @config["compress_cmd"],
    }

    missing_opts = opts.keys.select{|key| opts[key] == nil}
    unless missing_opts.empty?
      echo "Missing required configuration items #{missing_opts.inspect}",true
      return 1
    end
    # Optional socket config
    opts[:socket] = @config["mysql"]["socket"]
    # Optional backup timeout config, default is no timeout
    opts[:timeout] = @config["timeout"] || 0

    conn = Mysql.real_connect(opts[:host], opts[:user], opts[:passwd], 'mysql',
                              opts[:port].to_i, opts[:socket])
    result = conn.query("show databases;")
    dbs = []
    result.each {|db| dbs << db[0] }
    current_time = Time.now

    echo "Begin backup at #{current_time}"
    success, failed, ignored = [0,0,0]
    dbs.each do |name|
      result = exe_backup_db(opts.merge({:name => name, :ts => current_time}))
      case result
      when 0
        success += 1
      when 1
        failed += 1
      when -1
        ignored += 1
      else
      end

      if @shutdown
        raise Interrupt, "Interrupted"
      end
    end
    echo "Backup begins at #{current_time} complete. Success: #{success}. Failed #{failed}. Ignored #{ignored}."
    0
  end

  def exe_backup_db(opts)
    backup_cmd, compress_cmd, name, ts =
      %w(backup_cmd compress_cmd name ts).map{|k| opts[k.to_sym]}
    if IGNORE_DB.include?(name)
      echo "Ignore backup database #{name}."
      return -1
    elsif SYSTEM_DB.include?(name)
      # for system database, dir structure looks like \backups\<service-name>\
      # <db-name>\<seconds_since_epoc>\<node_id>\<service specific data>
      full_path = get_dump_path(name,1)
    else
      # dir structure looks like \backups\<service-name>\<aa>\<bb>\<cc>\
      # <aabbcc-rest-of-instance-guid>\<seconds_since_epoc>\<service specific data>
      full_path = get_dump_path(name)
    end
    opts.merge!({:full_path => full_path})
    # options substitution
    backup_cmd = opts.keys.inject(backup_cmd) do|cmd, key|
      cmd.gsub(":"+key.to_s, opts[key].to_s)
    end
    compress_cmd = opts.keys.inject(compress_cmd) do|cmd, key|
      cmd.gsub(":"+key.to_s, opts[key].to_s)
    end
    on_err = Proc.new do |cmd, code, msg|
      echo "CMD '#{cmd}' exit with code: #{code}. Message: #{msg}",true
      cleanup(full_path)
    end
    t1 = Time.now
    FileUtils.mkdir_p(full_path) unless File.exists?(full_path)
    res = CMDHandle.execute("#{backup_cmd};#{compress_cmd}", opts[:timeout].to_i, on_err)
    t2 = Time.now
    echo "Backup for db #{name} complete in #{t2-t1} seconds."
    return res ? 0:1
  rescue => e
    echo "Erorr when backup db #{opts[:name]}. #{e.backtrace.join("\n")}",true
    cleanup(full_path)
    return 1
  end

  def self.cleanup(path)
    FileUtils.rm_rf(path)
  end


end

VCAP::Services::Mysql::Backup.new.start
