require 'pry'
require 'json'

# Sample Command:
#   ruby convert_json_to_csv.rb song_json/winter_khalid_spotify_track_analysis.json

# 1.) Pass in a filename of a JSON song
input_filename = ARGV[0] # song_json/winter_khalid_spotify_track_analysis.json

# 2.) Open the file
input_file = File.open input_filename
song_data = JSON.load input_file

# 3.) Prepare output file
output_filename = input_filename.gsub('song_json', 'song_section_csv').gsub('.json', '.csv')
output_file = File.open(output_filename, 'w')

output_file << "Start Time,End Time,Duration,Key,Loudness,Mode,Tempo,Time Signature,Song Section,Intensity,Notes\n"

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

  output_file << "#{start_time},#{end_time},#{duration},#{key},#{loudness},#{mode},#{tempo},#{time_signature},#{song_section},#{intensity},#{notes}\n"
end
