# SwisstopoReframe

The ```SiwsstopoReframe``` Rubygem provides a simple client for the [Swisstopo Reframe REST API](http://www.swisstopo.admin.ch/internet/swisstopo/en/home/products/software/products/m2m.html).

The basic idea behind this client is to provide a tiny DSL for converting coordinates into different coordinate systems.

The following conversions are possible:

 * CH1903 <=> CH1903+ / (LV03 <=> LV95)
 * WGS84 <=> CH1903 / (WGS84 <=> LV03)
 * WGS84 <=> CH1903+ / (WGS84 <=> LV95)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'swisstopo_reframe'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install swisstopo_reframe

## Usage

To convert a point from a coordinate system A into a coordinate system B we need to know the following facts:
 
 * What kind of point is given? 
 * What kind of point do I need?
 * What's the value of the northing component?
 * What's the value of the easting component?
 * What's the value of the altitude component? (Optional)
    
So here is an example how we can convert a WGS84 point (gps) to a CH1903 point:
```ruby
result = SwisstopoReframe.reframe do
    northing 46.951082877
    easting 7.438632495
    altitude 550 # is optional
    given :wgs84
    need :ch1903
end
p result #=> {:easting=>"599999.9998992428", :northing=>"199999.9999671315", :altitude=>"500.37780122086406"} 
```

And here is an example to convert a CH1903 point to a WGS84 point:
```ruby
result = SwisstopoReframe.reframe do
    northing 200_000
    easting 600_000
    altitude 550 # is optional
    given :ch1903 
    need :wgs84
end
p result #=>  {:easting=>"7.438632502714565", :northing=>"46.95108288705891", :altitude=>"599.6221912624314"}
```

Other valid options for given and need are:
 
* given
  * :wgs84
  * :ch1903
  * :'ch1903+'


* need
  * :wgs84
  * :ch1903
  * :'ch1903+'


## Contributing

1. Fork it ( https://github.com/[my-github-username]/swisstopo_reframe/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
