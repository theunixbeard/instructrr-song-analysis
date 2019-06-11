require './rules/short_section_rule.rb'
require 'pry'
require 'json'

# Sample Command:
#   ruby convert_json_to_csv.rb song_json/winter_khalid_spotify_track_analysis.json

# 1.) Pass in a filename of a JSON song
input_filename = ARGV[0] # song_json/winter_khalid_spotify_track_analysis.json

# 2.) Open the file
input_file = File.open input_filename
song_data = JSON.load input_file

# 3.) Prepare Spotify output file
spotify_output_filename = input_filename.gsub('song_json', 'spotify_section_csv').gsub('.json', '.csv')
spotify_output_file = File.open(spotify_output_filename, 'w')

spotify_output_file << "Start Time,End Time,Duration,Key,Loudness,Mode,Tempo,Time Signature,Song Section,Intensity,Notes\n"

# 4.) Prepare Instructrr algo output file
instructrr_output_filename = input_filename.gsub('song_json', 'instructrr_section_csv').gsub('.json', '.csv')
instructrr_output_file = File.open(instructrr_output_filename, 'w')

instructrr_output_file << "Start Time,End Time,Duration,Key,Loudness,Mode,Tempo,Time Signature,Song Section,Intensity,Notes\n"

sections_to_combine = []

# 4.) Iterate over each section and create 1 row in the CSV
song_data['sections'].each do |s|
  start_time = s['start']
  end_time = s['start'] + s['duration']
  duration = s['duration']
  key = s['key']
  loudness = s['loudness']
  mode = s['mode']
  tempo = s['tempo']
  time_signature = s['time_signature']
  ###### Filled in manually (or in a future algorithm)
  song_section = '' # Intro, Verse, Pre-Chorus, etc.
  intensity = '' # 1 to 5 ...
  notes = '' # Whatever ...
  if short_section? s
    sections_to_combine << s
  end

  spotify_output_file << "#{start_time},#{end_time},#{duration},#{key},#{loudness},#{mode},#{tempo},#{time_signature},#{song_section},#{intensity},#{notes}\n"

  unless short_section?(s)
    if sections_to_combine.length > 0
      sections_to_combine << s
      # Combining short sections
      instructrr_output_file << combine_data(sections_to_combine)
      sections_to_combine = []
    else
      # Normal
      instructrr_output_file << "#{start_time},#{end_time},#{duration},#{key},#{loudness},#{mode},#{tempo},#{time_signature},#{song_section},#{intensity},#{notes}\n"
    end
  end

end
