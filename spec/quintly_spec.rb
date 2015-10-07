require 'spec_helper'
require 'vcr'

describe Quintly do
  let(:profile_ids) { 'profile_id1, profileid2' }

  let(:configuration) do
    double(
      'Quintly::Configuration',
      start_time: '2013-08-01',
      end_time: '2013-08-15',
      interval: 'daily', #(daily, weekly, monthly, yearly, total)
      profile_ids: profile_ids,
      username: 'username',
      password: 'password'
    )
  end

  subject { Quintly::QQL.new(configuration) }

  it 'has a version number' do
    expect(Quintly::VERSION).not_to be nil
  end

  it 'expects a configuration parameter' do
    expect(subject.configuration).to eq(configuration)
  end

  it 'get fanCount with QQL from api' do
    VCR.use_cassette 'query' do
      result = Quintly::QQL.new(configuration).query('SELECT profileId, time, fans FROM facebook')
      expect(profile_ids).to include(result.first['profileId'].to_s)
    end
  end

  it 'get fanCount from api' do
    VCR.use_cassette 'metric' do
      result = Quintly::QQL.new(configuration).metric('fanCount')
      expect(profile_ids).to include(result.first['dim1'].to_s)
    end
  end
end
