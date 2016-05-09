require File.expand_path(File.dirname(__FILE__) + '/../test_config.rb')

describe 'Series Model' do
  it 'can construct a new instance' do
    Series.new.wont_be_nil
  end

  it 'escapes and simplifies slug' do
    Series.new(slug: 'New_Slug välue').slug.must_equal 'new-slug-value'
  end

  it 'knows future events' do
    series = Series.new slug: 'some-series'
    now = Time.now
    event_a = Event.create(
        series_slug: 'some-series',
        start: now - 1,
        finish: (now + 10))
    event_b = Event.create(
        series_slug: 'some-series',
        start: now - 1,
        finish: (now + 10 * 60 * 60 * 24))
    event_c = Event.create(
        series_slug: 'some-series',
        start: now - 1,
        finish: (now - 10))
    event_d = Event.create(
        series_slug: 'other_series',
        start: now - 1,
        finish: (now + 10))
    series.future_events.must_include event_a
    series.future_events.must_include event_b
    series.future_events.wont_include event_c
    series.future_events.wont_include event_d
  end
end
