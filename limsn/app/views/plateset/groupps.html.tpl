<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>
<div class="container">
  <h1>Group Plate Sets</h1>

  <form action="/plateset/createbygroup" method="post">
    <div class="form-row">
      <div class="form-group col-md-6">
	<label>Date:</label> &nbsp <b><%= today %></b>
      </div>
      <div class="form-group col-md-6">
	<label>Owner:</label> &nbsp <b><%= username %></b>
      </div>
    </div>

    <div class="form-row">
      <div class="form-group col-md-6">
	<label for="name">New Plate Set Name:</label>  <input type="text" id="psname" name="psname"  class="form-control"  value="" required>
      </div>
      <div class="form-group col-md-6">
	<label for="descr">New Plate Set Description:</label>  <input type="text" id="descr" name="descr"  class="form-control"  value="" required>
      </div>
    </div>

    
  <div class="form-row">
      <div class="form-group col-md-12">
	<label for="psid-num">Plate Set ID (# plates):</label> &nbsp<b><%= ps-num-text %></b>
      </div>
  </div>
 <div class="form-row">

      <div class="form-group col-md-6">
	<label for="tot-pl">Total number of plates:</label>&nbsp&nbsp<b><%= tot-plates %></b>
	<input type="hidden" id="totplates" name="totplates" value=<%= totplatesq %>>
      </div>
   <div class="form-group col-md-6">     
	<label for="format">Plate Format:</label>&nbsp&nbsp<b><%= format %></b>
	<input type="hidden" id="format" name="format" value=<%= formatq %>>
   </div>
 </div>

 <div class="form-row">
   <div class="form-group col-md-12">
     <label for="sample">Sample Layout:</label>&nbsp&nbsp<b> <%= lyt-txt %></b>
   </div>
 </div>
 
 <div class="form-row">
 <div class="form-group col-md-12">
   <label for="type">Plate Type:</label>
   <select name="type" id="type" onchange="typeSelection(event)"  class="custom-select" > <%= plate-types %> </select> 
 </div>
</div>


<input type="hidden" id="lytid" name="lytid" value=<%= lytidq %>>

<input type="submit" class="btn btn-primary" value="Confirm and submit">
</form> 
</div>
  
<@include footer.tpl %>

 
