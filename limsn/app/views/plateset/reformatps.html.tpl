<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>
<div class="container">
  <h2>Reformat Plate Set PS-<%= srcpsid %></h2>
  <form action="/plateset/reformatconfirm" method="post">
    <div class="form-row">
      <div class="form-group col-md-6">
	<label>Date:</label> &nbsp <b><%= today %></b>
      </div>
      <div class="form-group col-md-6">
	  <label>Owner:</label> &nbsp <b><%= username %></b>
      </div>
    </div>
    <hr>
<div class="form-row">
      <div class="form-group col-md-12  text-center">
	<label><b><h4>Source Plate Set PS-<%= srcpsid %></h4></b></label> 
      </div>
    </div>

 <div class="form-row">

      <div class="form-group col-md-6">
	<label for="tot-pl">Total number of plates:</label>&nbsp&nbsp<b><%= srcnplates %></b>
	<input type="hidden" id="srcnplates" name="srcnplates" value=<%= srcnplates %>>
      </div>
   <div class="form-group col-md-6">     
	<label for="format">Plate Format:</label>&nbsp&nbsp<b><%= srcformat %></b>
	<input type="hidden" id="srcformat" name="srcformat" value=<%= srcformat %>>
   </div>
 </div>

 <div class="form-row">
   <div class="form-group col-md-12">
     <label for="sample">Sample Layout:</label>&nbsp&nbsp<b> <%= srcspllyttxt %></b>
   </div>
 </div>

    <hr>
<div class="form-row">
      <div class="form-group col-md-12 text-center">
	<label><b><h4>Destination (Reformatted) Plate Set</h4></b> </label> 
      </div>
    </div>

    
    <div class="form-row">
      <div class="form-group col-md-6">
	<label for="destname">New Plate Set Name:</label>  <input type="text" id="destname" name="destname"  class="form-control"  required>
      </div>
      <div class="form-group col-md-6">
	<label for="destdescr">New Plate Set Description:</label>  <input type="text" id="destdescr" name="destdescr"  class="form-control"   required>
      </div>
    </div>

 
 <div class="form-row">
 <div class="form-group col-md-6">
   <label for="desttype">New Plate Set Type:</label>
   <select name="desttype" id="desttype" onchange="typeSelection(event)"  class="custom-select" > <%= plate-types %> </select> 
 </div>
<div class="form-group col-md-6">
  <label for="destformat">New Format:&nbsp&nbsp<b><%= destformat %>&nbsp&nbsp well</b></label>
 </div>
</div>


 <div class="form-row">
 <div class="form-group col-md-6">
   <label for="type">Sample Replication:</label>
   <select name="destsamprep" id="destsamprep" onchange="sampRepSelection(event)"  class="custom-select" >
      <option value="1">1</option>  
	  <option value="2">2</option>
	  <option value="4">4</option> </select> 
 </div>
 <div class="form-group col-md-6">
   <label for="type">Target Replication:</label>
   <select name="desttargrep" id="desttargrep" onchange=""  class="custom-select" > <option value="0">--Select--</option> </select> 
 </div>
</div>

 
 <input type="hidden" id="srclytid" name="srclytid" value=<%= srclytidq %>>
 <input type="hidden" id="destformat" name="destformat" value=<%= destformatq %>>
 <input type="hidden" id="srcpsid" name="srcpsid" value=<%= srcpsidq %>>
 

<input type="submit" class="btn btn-primary" value="Submit">
</form> 
</div>

<script src="reformatps.js"></script>

<@include footer.tpl %>

 
