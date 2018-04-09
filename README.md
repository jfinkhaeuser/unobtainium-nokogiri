# unobtainium-nokogiri

This gem provides a driver implementation for [unobtainium](https://github.com/jfinkhaeuser/unobtainium)
based on [nokogiri](http://www.nokogiri.org/).

[![Gem Version](https://badge.fury.io/rb/unobtainium-nokogiri.svg)](https://badge.fury.io/rb/unobtainium-nokogiri)
[![Build status](https://travis-ci.org/jfinkhaeuser/unobtainium-nokogiri.svg?branch=master)](https://travis-ci.org/jfinkhaeuser/unobtainium-nokogiri)

To use it, require it after requiring unobtainium, then create the appropriate driver:

```ruby
require 'unobtainium'
require 'unobtainium-nokogiri'

include Unobtainium::World

drv = driver(:nokogiri)

# goto is provided by this gem, and wraps `open-uri`. Any URI accepted by that
# will work here.
drv.goto('http://finkhaeuser.de')

# Any other methods are delegated to nokogiri, such as e.g. `#xpath`
drv.xpath('//some/path')
```
