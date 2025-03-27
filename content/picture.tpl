<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
  <head>
    <title>Travel Log :</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="Content-Language" content="en" />
    <meta name="author" content="Tobias Schmid" />
    <link rel="stylesheet" type="text/css" href="../screen.css" title="Standard" media="screen" />
  </head>
  <body>
    <script>
      const data = [
        {{dataTable}}
      ]
      const galleryTitle = {{galleryTitle}}
      var index = 0
      window.onload = function() {
        index = Math.min(Math.max(0, localStorage.getItem(galleryTitle)||0), data.length-1)
        displayImage()
        const prevPicBtn = document.getElementById("left");
        prevPicBtn.style.cursor = "pointer";
        prevPicBtn.onclick = function() {
          index = Math.max(index - 1, 0)
          displayImage()
        };
        const nextPicBtn = document.getElementById("right");
        nextPicBtn.style.cursor = "pointer";
        nextPicBtn.onclick = function() {
          index = Math.min(index + 1, data.length-1)
          displayImage()
        };
      };
      function displayImage() {
        localStorage.setItem(galleryTitle, index);
        document.title = "Travel Log : " + data[index][4];
        const pos = document.getElementsByName("vpos")[0];
        pos.innerText = data[index][1].toString() + ", "+ data[index][2].toString();
        pos.href = "https://www.openstreetmap.org/?mlat=" + data[index][1].toString() + "&amp;mlon=" + data[index][2].toString() + "&amp;zoom=14"
        const pic = document.getElementsByName("vpic")[0];
        pic.src = data[index][3];
        pic.alt = data[index][4];
        pic.title = data[index][4];

        document.getElementsByName("vtitle")[0].innerText = data[index][4];
        document.getElementsByName("vtime")[0].innerText = data[index][5];
        
        const prevPicBtn = document.getElementById("left");
        const prevPic = document.getElementById("leftimg");
        if(index == 0){
          prevPicBtn.style.cursor = "auto";
          prevPic.src = "../dummy2.png"
        }
        else {
          prevPicBtn.style.cursor = "pointer";
          prevPic.src = "../left2.png"
        }
        const nextPicBtn = document.getElementById("right");
        const nextPic = document.getElementById("rightimg");
        if(index == data.length-1){
          nextPicBtn.style.cursor = "auto";
          nextPic.src = "../dummy2.png";
        }
        else {
          nextPicBtn.style.cursor = "pointer";
          nextPic.src = "../right2.png";
        }
      };
    </script>
    <div id="page">
      <h2><a name="vpos" href="">0, 0</a></h2>
      <div id="galleryImage">
        <div id="left"><img id="leftimg" src="../left2.png" alt="Previous Foto" title="Previous Foto"></div>
        <img class="pic" name="vpic" src="" alt="" title=""/>
        <div id="right"><img id="rightimg" src="../right2.png" alt="Next Foto" title="Next Foto"></div>
      </div>
      <div id="bottomtext">
        <div style="float:right;margin-top:-15px;"><a href="/"><img src="../up2.png" alt="Gallery" title="Gallery"></a></div>
        <h1 name="vtitle"></h1>
        <div name="vtime"></div>
        <br />
        <a href="map.html">Overview on OpenStreetMap.org</a>
        <div style="float:right; color: #666; text-align:right;">Copyright &copy; 2009-2024 Tobias Schmid</div>
      </div>
    </div>
  </body>
</html>
