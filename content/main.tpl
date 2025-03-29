<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
  <head>
    <title>Travel Log</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="Content-Language" content="en" />
    <meta name="author" content="Tobias Schmid" />
    <link rel="stylesheet" type="text/css" href="StartScreen.css" title="Standard" media="screen" />
    <script>
      window.onload = function() {
        var images = document.getElementsByClassName("randImage");
        let colorarray = []
        let arr = [0,1,2,3,4,5];
        while (colorarray.length < images.length) {
          colorarray = colorarray.concat(arr.sort((a, b) => 0.5 - Math.random()));
        }
        let n = 0;
        for (image of images) {
          const rndPos = Math.floor(Math.random() * 19) + 1
          image.src = image.src.replace("dummy", "title_" + colorarray[n].toString() + "_" + rndPos.toString())
          n++
        };
        var elements = document.getElementsByClassName("randImage")
        for (element of elements) {
          element.style.cursor = "pointer";
          element.onclick = function() {
            localStorage.setItem(this.alt, 0);
            window.open(this.alt + "/picture.html","_self")
            console.log("open Link:" +  this.alt + "/picture.html")
          };
        };
      };
    </script>
  </head>
  <body>
    <div id="startpage">
      <a href="/"><h1>TRAVEL LOG</h1></a>
      <div style="display: table; width:1060px;">
{{indexContent}}
      </div><br>
      <div id="copy">Copyright &copy; 2009-2025 Tobias Schmid<br></div>
    </div>
  </body>
</html>
