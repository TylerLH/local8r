# socket.js.coffee

window.socket =
  class Socket
    constructor: (opts) ->
      @channel = opts.channel
      @username = opts.username
      PUBNUB.subscribe
        channel: @channel
        restore: false
        callback: (message) =>
          $.growlUI('New message', message.text)
          coords = new google.maps.LatLng(message.lat, message.lng)
          window.userMap.addMarker({position: coords})
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
              lat: window.clientLocation.lat
              lng: window.clientLocation.lng
          $.ajax(
            '/start'
            dataType: 'json'
            type: 'post'
            data:
              name: @username
          )
          .error (err) ->
            console.log(err)