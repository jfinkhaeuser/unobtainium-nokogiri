# coding: utf-8
#
# unobtainium-nokogiri
# https://github.com/jfinkhaeuser/unobtainium-nokogiri
#
# Copyright (c) 2016 Jens Finkhaeuser and other unobtainium-nokogiri contributors.
# All rights reserved.
#

require 'unobtainium'

module Unobtainium
  ##
  # Nokogiri namespace
  module Nokogiri

    ##
    # Driver implementation using nokogiri (and open-uri).
    class Driver
      class << self
        ##
        # Return true if the given label matches this driver implementation,
        # false otherwise.
        def matches?(label)
          return :nokogiri == label.to_sym
        end

        ##
        # Ensure that the driver's preconditions are fulfilled.
        def ensure_preconditions(_, _)
          require 'nokogiri'
          require 'open-uri'
        rescue LoadError => err
          raise LoadError, "#{err.message}: you need to add "\
                "'nokogiri' to your Gemfile to use this driver!",
                err.backtrace
        end

        ##
        # Create and return a driver instance
        def create(_, _)
          driver = ::Unobtainium::Nokogiri::Driver.new
          return driver
        end
      end # class << self

      ##
      # "Go to" the given URI, i.e. open it and retain contents.
      def goto(uri)
        reset

        # Fetch content
        open(uri) do |f|
          @meta[:uri] = uri.dup
          if f.respond_to?(:meta)
            @meta[:headers] = f.meta.dup
            @meta[:status] = f.status.dup
            @meta[:base_uri] = f.base_uri.dup
          end

          if f.respond_to?(:metas)
            @meta[:split_headers] = f.metas.dup
          end

          @content = f.read
        end

        # Pass content to Nokigiri
        @parsed = ::Nokogiri.send(@parse_method, @content) do |config|
          config.options = @options
        end
      end

      ##
      # @return (String) The raw page content, or nil
      attr_reader :content

      ##
      # @return (Hash) Any page metadata, or an empty Hash
      attr_reader :meta

      ##
      # @return (::Nokogiri::XML::ParseOptions) parser options for all subsequent
      #   requests.
      attr_accessor :options

      ##
      # Set one of :XML or :HTML, deciding which parsing method nokogiri is to
      # use.
      def parse_method=(method)
        if not [:XML, :HTML].include?(method)
          raise ArgumentError, "parse_method must be one of :XML, :HTML!"
        end
        @parse_method = method
      end

      ##
      # @return (Symbol) one of :HTML, :XML
      attr_reader :parse_method

      ##
      # Map any missing method to nokogiri
      def respond_to_missing?(meth, include_private = false)
        if not @parsed.nil? and @parsed.respond_to?(meth, include_private)
          return true
        end
        return super
      end

      ##
      # Map any missing method to nokogiri
      def method_missing(meth, *args, &block)
        if not @parsed.nil? and @parsed.respond_to?(meth)
          return @parsed.send(meth.to_s, *args, &block)
        end
        return super
      end

      private

      ##
      # Private initialize to force use of Driver#create.
      def initialize
        reset

        @parse_method = :HTML
        @options = ::Nokogiri::XML::ParseOptions::DEFAULT_HTML
      end

      ##
      # Clear all data
      def reset
        @content = nil
        @meta = {}
        @parsed = nil
      end
    end # class Driver

  end # module Nokogiri
end # module Unobtainium

::Unobtainium::Driver.register_implementation(
    ::Unobtainium::Nokogiri::Driver,
    __FILE__
)
