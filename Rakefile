$LOAD_PATH.unshift(File.expand_path('../lib', __FILE__))
require 'unione-ruby'
require 'yaml'

task :console do
  exec "irb -r unione-ruby -I ./lib"
end

task :test do
  unione = UniOne::Client.new(
    hostname: ARGV[1],
    lang: 'en',
    api_key: ARGV[2],
    enable_logging: true,
  )

  webhook_url = ARGV[3].to_s.empty? ? nil : ARGV[3]
  from_email = ARGV[4].to_s.empty? ? nil : ARGV[4]
  config_file_path = ARGV[5].to_s.empty? ? './test/CONFIGFILE.yml' : ARGV[5]

  data = YAML.load_file(config_file_path)

  success = true

  data.each do |call|
    begin
      puts "## RUN: #{call['method']}"

      if call['method'] == 'callback_helper'
        unione.send(call['method'], call['params']) do |events|
          pp events
        end
      else
        if call['method'] == 'send_email'
          call['params']['message']['from_email'] = from_email if from_email
        elsif call['method'] == 'set_webhook'
          call['params']['url'] = webhook_url if webhook_url
        end

        unione.send(call['method'], call['params'])
      end

      puts "## => SUCCESS"
      puts ""
    rescue => e
      success = false
      puts "## => FAILED: #{e.message}"
    end
  end

  success ? exit : abort
end
