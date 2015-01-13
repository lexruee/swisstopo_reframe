# SwisstopoReframe

The ```SiwsstopoReframe``` Rubygem provides a simple client for the [Swisstopo Reframe REST API](http://www.swisstopo.admin.ch/internet/swisstopo/en/home/products/software/products/m2m.html).

The basic idea behind this client is to provide a DSL for converting coordinates into different coordinate systems.

```SiwsstopoReframe``` supports all conversions that are provided by [Swisstop Reframe REST API](http://www.swisstopo.admin.ch/internet/swisstopo/en/home/products/software/products/m2m.html).

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

To convert a point in a coordinate system A into a coordinate system B we need to know the following facts:

    * What kind of point is ```given```? 
    * What kind of point do I ```need```?
    * What's the value of the ```northing``` component of the point?
    * What's the value of the ```easting``` component of the point?
    * What's the value of the ```altitude``` component of the point? (Optional)
    
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

If you wish you can also specify a format in which the converted point should be returned.
Valid options for format are:
 
 * :json     (default)
 * :geojson
 
The response using ```:json``` looks like as follows:

```json
{"easting": "599999.7270399226", "northing": "199999.61419550685", "altitude": "500.3777916841209"}
```

The response using ```:geojosn``` looks like as follows:

```json
{ "type": "Point", "coordinates": [599999.7270399226, 199999.61419550685, 500.3777916841209] }
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/swisstopo_reframe/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
