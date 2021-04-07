<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis.
          
          
           -->
  
<@include header.tpl %>
<div class="container">
  <h1>Preview/Import Layout</h1>
  
  <p><h3>Sample Layout</h3></p>
 
  <image src= <%= spl-out2 %>>
    
    <form action="updatedb" method="POST">
      <div class="form-row">
	<div class="form-group col-md-6">
	  <label for="lytname">Layout Name</label>
	  <input type="text" class="form-control" id="lytname" name="lytname" placeholder="Enter layout name">
	</div>
	<div class="form-group col-md-6">
	  <label for="descr">Description</label>
	  <input type="text" class="form-control" id="descr" name="descr" value="1S1T">
	</div>
      </div>

      <div class="form-row">
	<div class="form-group col-md-6">
	  <label for="contloc">Control Location</label>
	  <input type="text" class="form-control" id="contloc" name="contloc" placeholder="Enter controls location">
	</div>
      </div>
      <div class="form-row">
	<div class="form-group col-md-12">
	  <label for="numunk">Number unknowns:&nbsp<%= nunks %></label>&nbsp&nbsp&nbsp
	  <label for="numcon">Number controls:&nbsp<%= ncontrols %></label>&nbsp&nbsp&nbsp
	  <label for="numcon">Number edge:&nbsp<%= nedge %></label>&nbsp&nbsp&nbsp
	  <label for="format">Format:&nbsp <%= format %></label>

	</div>
      </div>

      <input type="hidden" id="infile" name="infile" value=<%= infile %>>
      <input type="hidden" id="format" name="format" value=<%= format %>>
 <input type="hidden" id="nunks" name="nunks" value=<%= nunks %>>
 <input type="hidden" id="ncontrols" name="ncontrols" value=<%= ncontrols %>>
 <input type="hidden" id="nedge" name="nedge" value=<%= nedge %>>

      
 <input  class="btn btn-primary" id="importButton" name="importButton" type="submit" value="Import Layout" onclick="myFunction()" >

</form> 

 <button class="btn btn-primary" type="button" id="loadingButton" name="loadingButton" enabled>
  <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true" ></span>
  Loading...
</button>


    
</div>

<script>
  document.getElementById("importButton").style.display = "inline";
  document.getElementById("loadingButton").style.display = "none";
  
  function myFunction() {
      var x = document.getElementById("importButton");
      x.style.display = "none";
      var y = document.getElementById("loadingButton");
      y.style.display = "inline";
} 
    </script>


<@include footer.tpl %>

