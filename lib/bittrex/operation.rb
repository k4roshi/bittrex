module Bittrex
  class Operation
    attr_reader :market, :type, :quantity, :uuid, :fulfilled, :raw

    def initialize(type, market, quantity, rate, attrs = {})
      @market = market
      @quantity = quantity
      @type = type
      @rate = rate || 0
      @uuid = attrs['uuid']
      @fulfilled = false
      @raw = attrs
    end

    # Example:
    # Bittrex::Quote.current('BTC-HPY')
    def self.buy_market(market, quantity)
      new(:buy_market, market, client.get('market/buymarket', market: market, quantity: quantity))
    end

    def self.buy_limit(market, quantity, rate)
      new(:buy_limit, market, quantity, rate, client.get('market/buylimit', market: market, quantity: quantity, rate: rate))      
    end

    def self.sell_market(market, quantity)
      new(:sell_market, market, client.get('market/sellmarket', market: market, quantity: quantity))
    end

    def self.sell_limit(market, quantity, rate)
      new(:sell_limit, market, quantity, rate, client.get('market/selllimit', market: market, quantity: quantity, rate: rate))      
    end

    private

    def self.client
      @client ||= Bittrex.client
    end
  end
end
