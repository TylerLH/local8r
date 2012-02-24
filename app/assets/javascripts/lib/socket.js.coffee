# socket.js.coffee

window.socket =
  class Socket
    constructor: (opts) ->
      @channel = opts.channel
      @username = opts.username
      @latitude = opts.latitude
      @longitude = opts.longitude
      PUBNUB.subscribe
        channel: @channel
        restore: false
        callback: (message) =>
          $.growlUI('New message', message.text)
          console.log(message)

        disconnect: =>
          $.growlUI('Disconnected', "We'll automatically reconnect you")
          $.ajax(
            '/stop'
            dataType: 'json'
            type: 'post'
            data:
              name: @username
          )
          .success (res) ->
            console.log('disconnected user from roster')

        reconnect: =>
          $.growlUI('Reconnected', "..and we're back!")

        connect: =>
          PUBNUB.publish
            channel: @channel
            message:
              text: "#{@username} has joined."
          $.ajax(
            '/start'
            dataType: 'json'
            type: 'post'
            data:
              name: @username
          )
          .error (err) ->
            console.log(err)