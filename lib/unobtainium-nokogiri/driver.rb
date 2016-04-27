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
  module Nokogiri

    ##
    # TODO
    class Driver
      class << self
        def matches?(label)
          return :nokogiri == label.to_sym
        end

        def ensure_preconditions(_, _)
          # FIXME: better error
          require 'nokogiri'
        end

        def create(_, _)
          # TODO
        end
      end # class << self
    end # class Driver

  end # module Nokogiri
end # module Unobtainium

::Unobtainium::Driver.register_implementation(
    ::Unobtainium::Nokogiri::Driver,
    __FILE__)
