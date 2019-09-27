# require 'rubygems'
# require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/hell'
require 'httparty'

# Assumes each .txt file's last line is empty

# $ S='--------------';find . -name "*.txt" | while read line; do  echo "$S";echo "$line:";echo "$S";cat "$line"; done; echo ''
# --------------
# ./paths.txt:
#     --------------
# /about
# /hearbeat
# --------------
# ./protocols.txt:
#     --------------
# http://
# https://
# --------------
# ./domains.txt:
#     --------------
# google.com
# google.net
# google.org

DATA_PATH = ENV['DATA_PATH'].nil? ? '.' : ENV['DATA_PATH']
PROTOCOLS_PATH = "#{DATA_PATH}/protocols.txt"
DOMAINS_PATH = "#{DATA_PATH}/domains.txt"
PATHS_PATH = "#{DATA_PATH}/paths.txt"

Invalid = Class.new(StandardError)
def file_to_array(path)
  raise Invalid, "Missing file: #{path}" unless File.exists?(path)
  IO.read(path).split("\n")
end

PROTOCOLS = file_to_array(PROTOCOLS_PATH)
DOMAINS = file_to_array(DOMAINS_PATH)
PATHS = file_to_array(PATHS_PATH)

class Minitest::Test
  parallelize_me!
end

class RedirectsTest < Minitest::Test
  def test_paths
    PROTOCOLS.product(DOMAINS,PATHS) do|prefix, domain, postfix|
      puts "Testing: #{prefix+domain}#{postfix}"
      response = HTTParty.get("#{prefix+domain}#{postfix}", follow_redirects: false)
      assert_equal 301, response.code
      # assert_equal "https://www.#{domain}/#{path}", response.response['location']
    end
  end
end

