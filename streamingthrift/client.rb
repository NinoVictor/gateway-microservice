$:.push('gen-rb')
require 'thrift'
require 'streaming_service'


transport = Thrift::BufferedTransport.new(Thrift::Socket.new('localhost', 8000))
protocol = Thrift::BinaryProtocol.new(transport)
client = StreamingService::Client.new(protocol)

transport.open()

#Get track audio test
# track_audio = client.GetTrackAudio(TrackRequest.new(fileName: 'track1', quality: nil))

# File.open('../streaming/media/track3.mp3', 'w') do |destin_file|
#          destin_file.write track_audio.audio 
# end



# # # #Upload service test
# audio = ''
# File.open "../streaming/media/track1.mp3", "r" do |source_file|
#         until source_file.eof?
#             chunk = source_file.read 100000 
#             audio = audio + chunk
#         end
#     end

# begin
#         track_uploaded = client.UploadTrack(TrackAudio.new(idTrack: '1b70bf18-f1a6-449c-890c-78f7c19a5470',trackName: 'test', audio: audio)) 
#         puts track_uploaded.fileName

# rescue => exception
#        puts exception 
# end

#Upload personal track test
audio = ''
File.open "../streaming/media/track1.mp3", "r" do |source_file|
    until source_file.eof?
        chunk = source_file.read 100000 
        audio = audio + chunk
    end
end

begin
    track_uploaded = client.UploadPersonalTrack(TrackAudio.new(idTrack: 'b8bf4471-0681-40ad-ab0a-38910c24eb12',trackName: 'I love u', audio: audio)) 
    puts track_uploaded.fileName

rescue => exception
   puts exception 
end

transport.close()