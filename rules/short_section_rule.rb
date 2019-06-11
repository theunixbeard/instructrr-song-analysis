def short_section? s
  if s['duration'] < 10
    return true
  end
  return false
end

def combine_data raw_sections
  sections = raw_sections.map { |s| OpenStruct.new s }
  start_time = sections[0]['start']
  end_time = sections.last['start'] + sections.last['duration']
  duration = sections.inject(0){|sum,s| sum + s['duration'] }
  key = sections.map(&:key).join(';')
  loudness = sections.map(&:loudness).join(';')
  mode = sections.map(&:mode).join(';')
  tempo = sections.map(&:tempo).join(';')
  time_signature = sections.map(&:time_signature).join(';')
  song_section = ''
  intensity = ''
  notes = ''

  "#{start_time},#{end_time},#{duration},#{key},#{loudness},#{mode},#{tempo},#{time_signature},#{song_section},#{intensity},#{notes}\n"
end
