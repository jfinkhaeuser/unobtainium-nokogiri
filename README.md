# unobtainium-nokogiri

This gem provides a driver implementation for [unobtainium](https://github.com/jfinkhaeuser/unobtainium)
based on [nokogiri](http://www.nokogiri.org/).

[![Gem Version](https://badge.fury.io/rb/unobtainium-nokogiri.svg)](https://badge.fury.io/rb/unobtainium-nokogiri)
[![Build status](https://travis-ci.org/jfinkhaeuser/unobtainium-nokogiri.svg?branch=master)](https://travis-ci.org/jfinkhaeuser/unobtainium-nokogiri)
[![Code Climate](https://codeclimate.com/github/jfinkhaeuser/unobtainium-nokogiri/badges/gpa.svg)](https://codeclimate.com/github/jfinkhaeuser/unobtainium-nokogiri)
[![Test Coverage](https://codeclimate.com/github/jfinkhaeuser/unobtainium-nokogiri/badges/coverage.svg)](https://codeclimate.com/github/jfinkhaeuser/unobtainium-nokogiri/coverage)

To use it, require it after requiring unobtainium, then create the appropriate driver:

```ruby
require 'unobtainium'
require 'unobtainium-nokogiri'

include Unobtainium::World

drv = driver(:nokogiri)

# do something with the driver
```
