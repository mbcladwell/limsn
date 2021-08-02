<!-- utilities#setup view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
<@include header.tpl %>

<div class="container">
    <h1>Register</h1>

    Obtain a registration key so you can modify the <a href="http://labsolns.com/software/configuration/">configuration</a> parameter ‘cookie.maxplates’.

    <br><br>
<form action="/regformaction" method="post">
  <div class="container">
    <div class="row">
      
	<div class="form-group">
	  <label for="fname">First Name:</label> <input type="text" id="fname" class="form-control" name="fname" size="50">
      </div>
       
    </div>
    <div class="row">
    	<div class="form-group">
	    <label for="lname">Last Name:</label> <input type="text" id="lname" class="form-control" name="lname" size="50">
	</div>
	
    </div>
    <div class="row">
    	<div class="form-group">
	    <label for="institution">Institution:</label> <input type="text" id="institution" class="form-control" name="institution" size="50">
	</div>
	
    </div>
    <div class="row">
    	<div class="form-group">
	  <label for="email">email:</label><input type="text" id="email" class="form-control" name="email" size="50" placeholder="user@acme.com"> 
	
      </div>
     
    </div>
 <div>
   <button class="btn btn-primary">Register</button>
 </div>
 </div>
</form>




</div>
<@include footer.tpl %>
