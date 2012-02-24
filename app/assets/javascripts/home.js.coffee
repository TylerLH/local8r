# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# If browser supports html5 sessionStorage, check to see if user has their name stored
if Modernizr.sessionstorage
  window.username = window.sessionStorage.getItem('username') || null
else
  window.username = null

initializeMap = (position) ->
  mapOptions =
    location: 
      lat: position.coords.latitude
      lng: position.coords.longitude

  window.userMap = new window.map(mapOptions)
mapError = (err) ->
  $.growlUI('Houston, we have a problem...', "We couldn't pinpoint you on the map!")

$ ->
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition(initializeMap, mapError)
  else
    alert('Your device must support geolocation to use Local8r. Sorry!')

  # If user doesn't have a name stored in sessionStorage, get their preferred handle
  if window.username is null
    $('#get-started').modal(
      keyboard: false
      backdrop: 'static'
    ).modal('show')
  else
    # Otherwise connect the user to the global channel w/ their stored username
    window.globalChat = new window.socket({
      channel: 'global'
      username: window.username
    })
    $('li.username').append("<a href='#'>You are: <b>#{window.username}</b></a>")

  $('#start-btn').click (e) ->
    e.preventDefault()

    window.username = $('#username').val()
    window.sessionStorage.setItem('username', window.username)
    window.globalChat = new window.socket({
      channel: 'global'
      username: window.username
    })

  # Remove user from roster on window close
  $(window).unload ->
    $.ajax(
      '/stop'
      dataType: 'json'
      async: false
      type: 'post'
      data:
        name: window.username
    )
    .success (res) ->
      console.log('disconnected user from roster')