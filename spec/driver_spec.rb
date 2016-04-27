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
      require 'unobtainium-nokogiri'
    end.to_not raise_error(LoadError)
  end

  it "can be created" do
    expect do
      ::Unobtainium::Driver.create(:nokogiri)
    end.to_not raise_error

    drv = ::Unobtainium::Driver.create(:nokogiri)
    expect(drv).to_not be_nil
  end

  it "opens a file" do
    drv = ::Unobtainium::Driver.create(:nokogiri)

    test_uri = "spec/data/foo.html"
    expect { drv.goto(test_uri) }.to_not raise_error
    expect(drv.meta[:uri]).to eql test_uri
  end

  it "opens a web page" do
    drv = ::Unobtainium::Driver.create(:nokogiri)

    test_uri = "http://finkhaeuser.de"
    expect { drv.goto(test_uri) }.to_not raise_error
    expect(drv.meta[:uri]).to eql test_uri

    expect(drv.meta[:headers]).not_to be_nil
    expect(drv.meta[:headers]).not_to be_empty
  end

  it "delegates to nokogiri" do
    drv = ::Unobtainium::Driver.create(:nokogiri)

    test_uri = "spec/data/foo.html"
    expect { drv.goto(test_uri) }.to_not raise_error

    expect(drv.xpath('//foo')).not_to be_nil
    expect(drv.xpath('//foo')).not_to be_empty
  end

  it "rejects the wrong parse method" do
    drv = ::Unobtainium::Driver.create(:nokogiri)

    expect { drv.parse_method = :HTML }.not_to raise_error(ArgumentError)
    expect { drv.parse_method = :XML }.not_to raise_error(ArgumentError)

    expect { drv.parse_method = :foo }.to raise_error(ArgumentError)
    expect { drv.parse_method = 'XML' }.to raise_error(ArgumentError)
  end

  it "accepts and interprets configuration" do
    drv = ::Unobtainium::Driver.create(:nokogiri)

    drv.parse_method = :XML
    drv.options = ::Nokogiri::XML::ParseOptions::STRICT | \
                  ::Nokogiri::XML::ParseOptions::PEDANTIC

    test_uri = "spec/data/foo.html"
    expect { drv.goto(test_uri) }.to raise_error(Nokogiri::XML::SyntaxError)
  end
end
