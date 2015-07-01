require 'net/http'
require 'json'

WHEREABOUTS_URI = ENV["WHEREABOUTS_URI"]
SCHEDULER.every '10s', first_in: '1s' do |job|
  uri = URI(WHEREABOUTS_URI)
  whereabouts_data = JSON.parse Net::HTTP.get(uri)

  sick = whereabouts_data['staying_home']
  home = whereabouts_data['working_at_home']
  late = whereabouts_data['running_late']
  offsite = whereabouts_data['offsite']

  send_event('whereabouts', sick: sick, home: home, late: late, offsite: offsite)
end