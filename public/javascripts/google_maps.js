var user_timeline_url = "http://api.twitter.com/1/statuses/user_timeline.json";
var default_latitude = "35.657003";
var default_longitude = "139.696146";
var default_zoom = 15;

function initialize() {
//  if (GBrowserIsCompatible()) {
//    if (google.loader.ClientLocation &&
//        google.loader.ClientLocation.address.country_code == "US" &&
//        google.loader.ClientLocation.address.region) {

//       geo locate was successful and user is in the United States. range
//       check the region so that we can safely use it when selecting a
//       state level polygon overlay
//      var state = google.loader.ClientLocation.address.region.toUpperCase();
//        default_latitude = google.loader.ClientLocation.latitude;
//        default_longitude = google.loader.ClientLocation.longitude;
//    }
//  }

  var map = new GMap2(document.getElementById("map_canvas"));
  map.addControl(new google.maps.LargeMapControl());
  map.addControl(new google.maps.MapTypeControl());
  map.enableContinuousZoom();
  map.setCenter(new GLatLng(default_latitude, default_longitude), default_zoom);
  return map;
}

function getUserTimeline(username, count){
  var map = initialize();
  $.getJSON(user_timeline_url + "?screen_name=" + username + '&count=' + count + '&callback=?', function(data){
  // $.getJSON(user_timeline_url, { screen_name: username, count: count, callback: "?"}, function(data){
    $(data).each(function(){
      if(this.geo){
        // var point = new GLatLng(this.geo.coordinates[0], this.geo.coordinates[1]);
				var coordinates = getRandomGeoCode(this.geo.coordinates[0], this.geo.coordinates[1]);
				var point = new GLatLng(coordinates[0], coordinates[1]);
      } else if(this.user.location) {
        var coordinates = getGeoCode(this.user.location);
        // alert(coordinates);
				if(coordinates){
					var point = new GLatLng(coordinates[0], coordinates[1]);
				} else {
					var coordinates = getRandomGeoCode(default_latitude, default_longitude);
	        // var point = new GLatLng(default_latitude, default_longitude);
	        var point = new GLatLng(coordinates[0], coordinates[1]);
				}
      } else {
        var coordinates = getRandomGeoCode(default_latitude, default_longitude);
        // var point = new GLatLng(default_latitude, default_longitude);
        var point = new GLatLng(coordinates[0], coordinates[1]);
      }
      // Generate URL links
      text = generateLinks(this.text);;
      // Create markers
      map.addOverlay(createMarker(point, text, this.user.profile_image_url));
    });
  });
};

// Creates a marker whose info window displays the letter corresponding to the given index.
function createMarker(point, text, profile_image_url) {
  //   Create a base icon for all of markers that specifies the shadow, icon dimensions, etc.
  var baseIcon = new GIcon(G_DEFAULT_ICON);
  // baseIcon.image = "http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png";
  baseIcon.shadow = "http://www.google.com/mapfiles/shadow50.png";
  baseIcon.iconSize = new GSize(50, 50);
  baseIcon.shadowSize = new GSize(70, 70);
  baseIcon.iconAnchor = new GPoint(25, 25);
  baseIcon.infoWindowAnchor = new GPoint(25, 0);
  // The first pair is the top/left corner, the second pair is top/right, 
  //    the third is bottom/right, and the fourth is bottom/left.
  baseIcon.imageMap = [0,0, 49,0, 49,49, 0,49];

  // Create an icon for this point using a profile image
  baseIcon.image = profile_image_url;
  var twitterIcon = new GIcon(baseIcon);

  // Set up GMarkerOptions object
  markerOptions = { icon:twitterIcon };
  var marker = new GMarker(point, markerOptions);

  // Create a window with a tweet
  GEvent.addListener(marker, "mouseover", function() {
    marker.openInfoWindowHtml(text);
  });
  return marker;
}

function generateLinks(text) {
  // Generate URL links
  var parse_url = /\s?(?:http|https):\/\/[0-9.a-zA-Z\-\?_\/]+\s?/;
  return text.replace(parse_url, "<a href=\"$&\" target=\"blanck\">$&</a>");
}

function getGeoCode(location) {
  // var geocoding_url = "http://maps.google.com/maps/geo?sensor=true&key=ABQIAAAA8okg8mFeZMRCeMhD2smigxSeKJA9Q9LWxX8b77SUrWIUujPJ0RTaSxkKv08xO_3BmIFxtspwHxC7Hg&output=json&q=";
  //   $.getJSON(geocoding_url + encodeURI(location) + '&callback=?', function(data){
	var geocoding_url = "http://maps.google.com/maps/geo";
	$.get(geocoding_url, {sensor: "true", key: "ABQIAAAA8okg8mFeZMRCeMhD2smigxSeKJA9Q9LWxX8b77SUrWIUujPJ0RTaSxkKv08xO_3BmIFxtspwHxC7Hg", output: "json", q: encodeURI(location), callback: "?"}, function(data){
    var coordinates = getRandomGeoCode(data.Placemark[0].Point.coordinates[0], data.Placemark[0].Point.coordinates[1]);
    return coordinates;
  })
}

function getRandomGeoCode (lat, long) {
  var coordinates = [eval(lat) + (Math.random() * 200 - 100) / 100000, eval(long) + (Math.random() * 200 - 100) / 100000];
  return coordinates;
}