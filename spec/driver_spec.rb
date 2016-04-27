# coding: utf-8
#
# unobtainium-nokogiri
# https://github.com/jfinkhaeuser/unobtainium-nokogiri
#
# Copyright (c) 2016 Jens Finkhaeuser and other unobtainium-nokogiri contributors.
# All rights reserved.
#
require 'spec_helper'

describe 'Unobtainium::Nokogiri::Driver' do
  it "passes unobtainium's interface checks" do
    expect do
      require_relative '../lib/unobtainium-nokogiri/driver'
    end.to_not raise_error(LoadError)
  end
end
