# map.js.coffee

window.map =
	class Map
		# Builds the map & appends it to the #map_canvas element
		constructor: (opts) ->
			@location = new google.maps.LatLng(opts.location.lat, opts.location.lng)

			@mapOptions =
		    zoom: 8
		    disableDefaultUI: true
		    center: @location
		    mapTypeId: google.maps.MapTypeId.ROADMAP

		  @map = new google.maps.Map(document.getElementById("map_canvas"), @mapOptions)

		  # Add a marker with user position
		  # markerOpts =
			#		position: @location
			#		title: "This is you!"
		  # @addMarker(markerOpts)

		# Adds a marker to the map
		addMarker: (opts) =>
			markerOpts = 
				position: opts.position
				title: opts.title
				map: @map

			marker = new google.maps.Marker(markerOpts)