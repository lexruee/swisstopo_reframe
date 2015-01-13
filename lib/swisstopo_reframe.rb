require "swisstopo_reframe/version"
require 'json'
require 'net/http'

module SwisstopoReframe

  class Reframe

    LOOKUP = {
        [:wgs84, :lv95] => 'wgs84tolv95',
        [:wgs84, :lv03] => 'wgs84tolv03',

        [:lv95, :lv03] => 'lv95tolv03',
        [:lv95, :wgs84] => 'lv95towgs84',

        [:lv03, :wgs84] => 'lv03towgs84',
        [:lv03, :lv95] => 'lv03tolv95',

        # alias
        [:wgs84, :'ch1903+'] => 'wgs84tolv95',
        [:wgs84, :ch1903] => 'wgs84tolv03',

        [:ch1903, :lv95] => 'lv03tolv95',
        [:ch1903, :'ch1903+'] => 'lv03tolv95',
        [:ch1903, :wgs84] => 'lv03towgs84',

        [:'ch1903+', :lv03] => 'lv95tolv03',
        [:'ch1903+', :ch1903] => 'lv95tolv03',
        [:'ch1903+', :wgs84] => 'lv95towgs84'
    }


    BASE_URL = 'http://tc-geodesy.bgdi.admin.ch/reframe/'

    attr_writer :easting, :northing, :altitude, :given, :format, :want

    def easting(value)
      @easting = value
    end

    def northing(value)
      @northing = value
    end

    def altitude(value)
      @altitude = value
    end

    def need(value)
      @want = value
    end

    def given(value)
      @given = value.to_s.downcase.to_sym
    end

    def format(value)
      @format = value
    end

    def request
      uri_string = request_url + '?' + query_string
      uri = URI(uri_string)
      response = Net::HTTP.get_response(uri)
      response
    end

    private

    def request_url
      converter = [@given, @want]
      path = LOOKUP[converter]
      raise 'converter not found!' if path.nil?
      BASE_URL + path
    end

    def query_string
      format = @format.nil? ? 'json' : @format
      altitude = @altitude.nil? ? '' : @altitude
      "northing=#{@northing}&easting=#{@easting}&altitude=#{altitude}&format=#{format}"
    end

  end

  def self.new
    Reframe.new
  end

  def self.reframe(&block)
    reframe = Reframe.new
    reframe.instance_eval &block
    request = reframe.request
    handle(request)
  end

  private

  def self.handle(request)
   case request.code.to_i
     when 200
       JSON.parse(request.body, symbolize_names: true)
     else
       raise 'HTTP Error, status: %s' % request.code
   end
  end

end
