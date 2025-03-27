<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en" dir="ltr">
  <head>
    <title>Travel Log : Map</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="Content-Language" content="en" />
    <meta name="author" content="Tobias Schmid" />
    
    <link rel="stylesheet" type="text/css" href="../screen.css" title="Standard" media="screen" />
    <link rel="stylesheet" type="text/css" href="../leaflet.css" title="Standard" media="screen" />
    <link rel="stylesheet" type="text/css" href="../map.css" title="Standard" media="screen" />
  </head>
  <body>
    <div id="page">
      <h2>Map</h2>
      <div style="margin: 10px 30px 10px 30px;">
        <div id="mapdiv" style="width:1000px;height:666px">
        </div>
      </div>  
      <div id="bottomtext">
        <div style="float:right;margin-top:-12px;"><a href="/"><img src="../up2.png" alt="Gallery" title="Gallery"></a></div>
        <h1>Legend:</h1><br />
        <img src="../marker-red.png" height="18" alt="Red Marker" />  Picture Location
        <div style="float:right; color: #666; text-align:right;">Copyright &copy; 2009-2024 Tobias Schmid</div>
      </div>
    </div>
    <script src="../leaflet.js"></script>
    <script type="text/javascript">
      var map = L.map('mapdiv').{{mapView}}
      L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        maxZoom: 18,
        attribution: 'Map data &copy; <a href="https://openstreetmap.org">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>'
      }).addTo(map);
      
      var redMarker = L.icon({
        iconUrl: '../marker-red.png',
        iconRetinaUrl: '../marker-red.png',
        iconSize: [25, 41],
        iconAnchor: [12, 40],
        popupAnchor: [2, -35]
      });
      
      var blueMarker = L.icon({
        iconUrl: '../marker-blue.png',
        iconRetinaUrl: '../marker-blue.png',
        iconSize: [25, 41],
        iconAnchor: [12, 40],
        popupAnchor: [2, -35]
      });
      const data = [
        {{dataTable}}
      ]
      const galleryTitle = {{galleryTitle}}
      var index = 0
      selectedIndex = Math.min(Math.max(0, localStorage.getItem(galleryTitle)||0), data.length-1)
      for (element of data) {
        var colorMarker = redMarker
        if (index == selectedIndex){
          colorMarker = blueMarker
        }
        var marker = L.marker([element[1], element[2]], {icon: colorMarker}).addTo(map);
        marker.bindPopup("<b>" + element[4] + "</b><br><a href=\"picture.html\" onclick=\"localStorage.setItem(galleryTitle, " + index + ");return true;\"><img src=\"t_" + element[3] + "\" alt=\"" + element[4] + "\" title=\"" + element[4] + "\" /></a>");
        index = index + 1
      };
    </script>
  </body>
</html>