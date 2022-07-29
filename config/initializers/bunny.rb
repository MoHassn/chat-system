# conn = Bunny.new(
#   host: ENV['RABBITMQ_HOST'],
#   user:  'rabbitmquser',
#   pass:  'rabbitmquser'
# )
# # conn = Bunny.new "amqp://guest:guest@rmq:5672"
# conn.start
# ch = conn.create_channel

# queue = ch.queue('messages')

# begin
#   queue.subscribe do |_delivery_info, _properties, body|
#     message = JSON.parse(body)
#     chat = Chat.find(message["chat"])
#     chat.messages.create(number: message["number"], body: message["body"])
#     puts " [x] Received #{JSON.parse(body)}"
#   end
# rescue Interrupt => _
#   ch.close

#   exit(0)
# end