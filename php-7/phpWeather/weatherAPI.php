<?php
    
    $weather = "";
    $error = "";
    
    if ($_GET['city']) {
        
     $urlContents = file_get_contents("http://api.openweathermap.org/data/2.5/weather?q=".urlencode($_GET['city']).",uk&appid=APP_KEY");
        
        $weatherArray = json_decode($urlContents, true);
        
        if ($weatherArray['cod'] == 200) {
        
            $weather = "The weather in ".$_GET['city']." is currently '".$weatherArray['weather'][0]['description']."'. ";

            $tempInFahrenheit = intval(($weatherArray['main']['temp'] - 273) * 1.8 + 32);

            $weather .= " The temperature is ".$tempInFahrenheit."&deg;F and the wind speed is ".$weatherArray['wind']['speed'] * (9/4)." miles per hour.";
            
        } else {
            
            $error = "Could not find city - please try again.";
            
        }
        
    }


?>


<!DOCTYPE html>
<html lang="en">
  <head>
    <!-- Required meta tags always come first -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

      <title>Weather  </title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.2/css/bootstrap.min.css" integrity="sha384-y3tfxAZXuh4HwSYylfB+J125MxIs6mR5FOHamPBG064zB+AFeWH94NdvaCBm8qnd" crossorigin="anonymous">
<link href="../css/email.css" rel="stylesheet" type="text/css"> 
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','../js/analytics.js','ga'); 
  ga('create', 'UA-71584977-1', 'auto');
  ga('send', 'pageview');
</script>  
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.2/js/bootstrap.min.js" ></script>
      <style type="text/css">
      
        
          body {
              
             
              
          }
          
          .container {
            padding:10px;
	 
            height:900px;
              
            
              
          }

        #map {
	background-color:yellow;
	height:600px; 
	width:100%;
border:solid .5px blue;
}
          input {
              
              margin: 20px 0;
	      max-width:400px;
              
          }
          
          #weather {
              
 
          }
         
      </style>
      
  </head>
  <body>
     <h5 ><a id="tmmreturn" style="margin-right:10%" href="../index.html">back to T M M</a></h5>
      <div  class="container">
     
          <h3>Query your city's weather:</h3>
          
          
          
          <form>
  <fieldset class="form-group">
   
    <input type="text" class="form-control" name="city" id="city" style="width:350px" placeholder=" e.g. Albuquerque, Paris" value = "<?php echo $_GET['city']; ?>">
 
 
</fieldset>
  <input style="float:right;margin-right:200px;" type="submit" value="Map Reset">
  <button type="submit" class="btn btn-primary">Submit</button>
 
  
<br /><br />
</form>
      
          <div id="weather"><?php 
              
              if ($weather) {
                  
                  echo '<div class="alert alert-success" role="alert">
  '.$weather.'
</div>';
                  
              } else if ($error) {
                  
                  echo '<div class="alert alert-danger" role="alert">
  '.$error.'
</div>';
                  
              }
              
              ?></div>

<div id="map"></div>
	<script>

      // Note: This example requires that you consent to location sharing when

      // prompted by your browser. If you see the error "The Geolocation service

      // failed.", it means you probably did not give permission for the browser to

      // locate you.

      var map, infoWindow;

      function initMap() {

        map = new google.maps.Map(document.getElementById('map'), {

          center: {lat: 35.113281, lng: -106.621216},

          zoom: 6

        });

        infoWindow = new google.maps.InfoWindow;



        // Try HTML5 geolocation.

/*     if (navigator.geolocation) {

          navigator.geolocation.getCurrentPosition(function(position) {

            var pos = {

              lat: position.coords.latitude,

              lng: position.coords.longitude

            };



            infoWindow.setPosition(pos);

            infoWindow.setContent('Location found.');

            infoWindow.open(map);

            map.setCenter(pos);

          }, function() {

            handleLocationError(true, infoWindow, map.getCenter());

          });

        } else {

          // Browser doesn't support Geolocation

          handleLocationError(false, infoWindow, map.getCenter());

        }

*/


      }

    </script>

    <script async defer

    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCYEbB9-X0hdo2pM0Fb9uo5CDvsWA8e6ao&callback=initMap">

    </script>


</div>
      </div>


    <!-- jQuery first, then Bootstrap JS. -->
   
  </body>
</html>