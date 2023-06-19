require_relative 'har_request'
require 'json'

module BadPigeon
  class HARArchive
    def initialize(data)
      @json = JSON.parse(data)
    end

    def entries
      @json['log']['entries'].map { |j| HARRequest.new(j) }
    end
  end
end