require 'spec_helper'

module SwisstopoReframe

  describe SwisstopoReframe do

    it "tests conversion from wgs84 to ch1903" do
      result = SwisstopoReframe.reframe do
        northing 46.951082877
        easting 7.438632495
        given :wgs84
        need :ch1903
        format :geojson
      end
      expect(result).not_to be_nil
      expect(599_999.7270399226).to be_within(1).of(result[:coordinates][0])
      expect(199_999.61419550685).to be_within(1).of(result[:coordinates][1])
    end


    it "tests conversion from wgs84 to ch1903+" do
      result = SwisstopoReframe.reframe do
        northing 46.951082877
        easting 7.438632495
        given :wgs84
        need :'ch1903+'
        format :geojson
      end
      expect(result).not_to be_nil
      expect(2_599_999.810036594).to be_within(1).of(result[:coordinates][0])
      expect(1_199_999.6801912596).to be_within(1).of(result[:coordinates][1])
    end


    it "tests conversion from wgs84 to lv03" do
      result = SwisstopoReframe.reframe do
        northing 46.951082877
        easting 7.438632495
        given :wgs84
        need :lv03
        format :geojson
      end
      expect(result).not_to be_nil
      expect(599_999.7270399226).to be_within(1).of(result[:coordinates][0])
      expect(199_999.61419550685).to be_within(1).of(result[:coordinates][1])
    end


    it "tests conversion from wgs84 to lv95" do
      result = SwisstopoReframe.reframe do
        northing 46.951082877
        easting 7.438632495
        given :wgs84
        need :lv95
        format :geojson
      end
      expect(result).not_to be_nil
      expect(2_599_999.810036594).to be_within(1).of(result[:coordinates][0])
      expect(1_199_999.6801912596).to be_within(1).of(result[:coordinates][1])
    end


    it "tests conversion from ch1903 to wgs84" do
      result = SwisstopoReframe.reframe do
        northing 200_000
        easting 600_000
        given :ch1903
        need :wgs84
        format :geojson
      end
      expect(result).not_to be_nil
      expect(46.95108287667706).to be_within(0.1/3600).of(result[:coordinates][1])
      expect(7.438632495).to be_within(0.1/3600).of(result[:coordinates][0])
    end


    it "tests conversion from lv03 to wgs84" do
      result = SwisstopoReframe.reframe do
        northing 200_000
        easting 600_000
        given :lv03
        need :wgs84
        format :geojson
      end
      expect(result).not_to be_nil
      expect(46.95108287667706).to be_within(0.1/3600).of(result[:coordinates][1])
      expect(7.438632495).to be_within(0.1/3600).of(result[:coordinates][0])
    end


    it "tests conversion from ch1903+ to wgs84" do
      result = SwisstopoReframe.reframe do
        northing 1_200_000
        easting 2_600_000
        given :'ch1903+'
        need :wgs84
        format :geojson
      end
      expect(result).not_to be_nil
      expect(46.95108287667706).to be_within(0.1/3600).of(result[:coordinates][1])
      expect(7.438632495).to be_within(0.1/3600).of(result[:coordinates][0])
    end


    it "tests conversion from lv95 to wgs84" do
      result = SwisstopoReframe.reframe do
        northing 1_200_000
        easting 2_600_000
        given :lv95
        need :wgs84
        format :geojson
      end
      expect(result).not_to be_nil
      expect(46.95108287667706).to be_within(0.1/3600).of(result[:coordinates][1])
      expect(7.438632495).to be_within(0.1/3600).of(result[:coordinates][0])
    end


    it "tests conversion from lv95 to lv03" do
      result = SwisstopoReframe.reframe do
        northing 1_200_000
        easting 2_600_000
        given :lv95
        need :lv03
        format :geojson
      end
      expect(result).not_to be_nil
      expect(600_000).to be_within(1).of(result[:coordinates][0])
      expect(200_000).to be_within(1).of(result[:coordinates][1])
    end


    it "tests conversion from ch1903+ to ch1903" do
      result = SwisstopoReframe.reframe do
        northing 1_200_000
        easting 2_600_000
        given :lv95
        need :lv03
        format :geojson
      end
      expect(result).not_to be_nil
      expect(600_000).to be_within(1).of(result[:coordinates][0])
      expect(200_000).to be_within(1).of(result[:coordinates][1])
    end


    it "tests conversion from lv03 to lv95" do
      result = SwisstopoReframe.reframe do
        northing 200_000
        easting 600_000
        given :lv03
        need :lv95
        format :geojson
      end
      expect(result).not_to be_nil
      expect(2_600_000).to be_within(1).of(result[:coordinates][0])
      expect(1_200_000).to be_within(1).of(result[:coordinates][1])
    end


    it "tests conversion from ch1903 to ch1903+" do
      result = SwisstopoReframe.reframe do
        northing 200_000
        easting 600_000
        given :ch1903
        need :'ch1903+'
        format :geojson
      end
      expect(result).not_to be_nil
      expect(2_600_000).to be_within(1).of(result[:coordinates][0])
      expect(1_200_000).to be_within(1).of(result[:coordinates][1])
    end

  end

end