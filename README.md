# unobtainium-nokogiri

This gem provides a driver implementation for [unobtainium](https://github.com/jfinkhaeuser/unobtainium)
based on [nokogiri](http://www.nokogiri.org/).

To use it, require it after requiring unobtainium, then create the appropriate driver:

```ruby
require 'unobtainium'
require 'unobtainium-nokogiri'

include Unobtainium::World

drv = driver(:nokogiri)

# do something with the driver
```
