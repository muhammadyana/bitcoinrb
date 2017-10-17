require 'rest-client'
require 'thor'
require 'json'

module Bitcoin
  module Node

    class CLI < Thor

      class_option :network, aliases: '-n', default: :mainnet

      desc 'getblockchaininfo', 'Returns an object containing various state info regarding blockchain processing.'
      def getblockchaininfo
        request('getblockchaininfo')
      end

      desc 'stop', 'Stop Bitcoin server.'
      def stop
        request('stop')
      end

      private

      def config
        opts = {}
        opts[:network] = options['network'] if options['network']
        @conf ||= Bitcoin::Node::Configuration.new(opts)
      end

      def request(command, *params)
        data = {
            :method => command,
            :params => params,
            :id => 'jsonrpc'
        }
        begin
          RestClient::Request.execute(method: :post, url: config.server_url, payload: data.to_json,
                                      headers: {content_type: :json}) do |response, request, result|
            return false if !result.kind_of?(Net::HTTPSuccess) && response.empty?
            json = JSON.parse(response.to_str)
            puts JSON.pretty_generate(json)
          end
        rescue Exception => e
          puts e.message
        end
      end

    end
  end
end