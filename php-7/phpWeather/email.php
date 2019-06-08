<?php
 
   	 $error = ""; 
	 $successMessage = ""; 

    if ($_POST) { 

        if (!$_POST["email"]) {
 

            $error .= "Oops, a valid email address is required for post :-)<br>";
 
            

        }

        

        if (!$_POST["content"]) {

            

            $error .= "The content field is required.<br>";

            

        }

        

        if (!$_POST["subject"]) {

            

            $error .= "The subject is required.<br>";

            

        }

        

        if ($_POST['email'] && filter_var($_POST["email"], FILTER_VALIDATE_EMAIL) === false) {

            

            $error .= "Oops, a valid email address is required for post :-)<br>";

            

        }

        

        if ($error != "") {

            

            $error = '<div class="alert alert-danger" role="alert"><p>There were error(s) in your form:</p>' . $error . '</div>';

            

        } else {

            

            $emailTo = "thomas.maestas@hotmail.com";

            

            $subject = $_POST['subject'];

            

            $content = $_POST['content'];

            

            $headers = "From: ".$_POST['email'];

            

            if (mail($emailTo, $subject, $content, $headers)) {

                
  		mail($emailTo, $subject, $content, $headers);
                $successMessage = '<div class="alert alert-success" role="alert">Thank you, this submission received by TMM, please expect a 
prompt response from thomas76milton@gmail.com, to your provided address, <strong> '.$_POST['email'].'</strong>, within 48 hours.</div>';

                

                

            } else {

                

                $error = '<div class="alert alert-danger" role="alert"><p><strong>Your message couldn\'t be sent - please try again later</div>';

                

                

            }

            

        }

        

        

        

    }



?>



<!DOCTYPE html>

<html lang="en">

  <head> 

    <meta charset="utf-8">

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <meta http-equiv="x-ua-compatible" content="ie=edge">



    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.2/css/bootstrap.min.css">
<script src='https://www.google.com/recaptcha/api.js'></script>
<script src="https://d3js.org/d3.v4.min.js"></script>

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','../js/analytics.js','ga'); 
  ga('create', 'UA-71584977-1', 'auto');
  ga('send', 'pageview');
</script>



<style type="text/css">
  
#tmm_bck { 
    margin-top:30px;
    padding:10px;
    color:teal;
    max-width:150px; 
    text-decoration:none; 
    background-color: #dfeef7;
    box-shadow: 0px 10px 50px rgba(0, 0, 0, 0.3);
} 
#tmm_bck:hover {
    font-weight: 800;
    color:brown;
    text-decoration:none;
    border:solid 1px white; 
    transition: margin 0.3s; 	}
    </style>
</head>

  <body>
<script>
      
d3.select("body").transition()
    .duration(3000)
	.delay(400)
    .style("background-color", "teal");

d3.select("div").transition()
    .duration(3000)
	.delay(400)
    .style("background-color", "white");

</script>
      <div class="container" >

 
<div id="tmm_bck">
	   <a  href="http://www.thomasmaestas.net"><h5 >back to T M M</h5></a>
</div>

          <br /><br />

      <div id="error"><? echo $error.$successMessage; ?></div>
<div>
      

      <form method="post">

  <fieldset class="form-group">

    <label for="email">Your email address</label>

    <input type="email" class="form-control" id="email" name="email" placeholder="your_email@email.com">


  </fieldset>

  <fieldset class="form-group">

    <label for="subject">Subject</label>

    <input type="text" class="form-control" id="subject" name="subject" >

  </fieldset>

  <fieldset class="form-group">

    <label for="exampleTextarea">Message</label>

    <textarea class="form-control" id="content" name="content" rows="3"></textarea>

  </fieldset>

  <button type="submit" id="submit" class="btn btn-primary">Contact Tom</button>
<br /><br />
</form>
</div>

          

        </div>



    <!-- jQuery first, then Bootstrap JS. -->

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.2/js/bootstrap.min.js" integrity="sha384-vZ2WRJMwsjRMW/8U7i6PWi6AlO1L79snBrmgiDpgIWJ82z8eA5lenwvxbMV1PAh7" crossorigin="anonymous"></script>

          

          

    <script type="text/javascript">

          

          $("form").submit(function(e) {

              

              var error = "";

              

              if ($("#email").val() == "") {

                  

                  error += "The email field is required.<br>"

                  

              }
	
		 

              if ($("#subject").val() == "") {

                  

                  error += "The subject field is required.<br>"

                  

              }

              

              if ($("#content").val() == "") {

                  

                  error += "The content field is required.<br>"

                  

              }

              

              if (error != "") {

                  

                 $("#error").html('<div class="alert alert-danger" role="alert">
		<p><strong>There were error(s) in your form entry:</strong></p>' + error + '</div>');

                  

                  return false;

                  

              } else {

                  

                  return true;

                  

              }

          })

          

<!--
<script> $("form").submit(function(e){
        e.preventDefault();
    });
 -->
	
 <!-- jQuery first, then Tether, then Bootstrap JS. -->
    <script src="https://code.jquery.com/jquery-3.1.1.slim.min.js" integrity="sha384-A7FZj7v+d/sdmMqp/nOQwliLvUsJfDHW+k9Omg/a/EheAdgtzNs3hpfag6Ed950n" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>
 </div> 
 <!-- Go to www.addthis.com/dashboard to customize your tools --> <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-58b774f963b674cb"></script>
 </body>

</html>