<!-- utilities#setup view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
<@include header.tpl %>

<div class="container">
<h1>Register</h1>

<form action="/registeraction" method="post">
  <div class="container">
    <div class="row">
      
	<div class="form-group">
	  <label for="prj">Registration ID:</label>
	  <input type="text" id="custid" class="form-control" name="custid" size="60" placeholder="e.g. 16fjkhwF2rkdbwogqLdHZG4fb87jUxtJBU">
	
      </div>
       
    </div>
    <div class="row">
    	<div class="form-group">
	  <label for="custkey">Registration Key:</label>
	  <input type="text" id="custkey" class="form-control" name="custkey" size="60" placeholder="e.g. c1f400d8222fbe8b1fec6c24cccf14a2">
	
      </div>
       
    </div>
    <div class="row">
    	<div class="form-group">
	  <label for="email">email:</label><input type="text" id="email" class="form-control" name="email" size="60" placeholder="user@acme.com"> 
	
      </div>
     
    </div>
 <div>
   <button class="btn btn-primary">Register</button>
 </div>
 </div>
</form>




</div>
<@include footer.tpl %>
