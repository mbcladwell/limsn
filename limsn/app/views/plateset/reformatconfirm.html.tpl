<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>
<div class="container">
  <h2>Reformat Plate Set PS-<%= srcpsid %></h2>
  <form action="/plateset/reformataction" method="post">
    <div class="form-row">
      <div class="form-group col-md-6">
	<label>Date:</label> &nbsp <b><%= today %></b>
      </div>
      <div class="form-group col-md-6">
	<label>Owner:</label> &nbsp <b><%= username %></b>
      </div>
    </div>

<div class="form-row">
      <div class="form-group col-md-12 text-center">
	<label><b>Reformatted Plate Set</b> </label> 
      </div>
    </div>

    
    <div class="form-row">
      <div class="form-group col-md-12">
	<label for="destname">Name:</label>&nbsp;&nbsp;<b><%= destname %></b>  
      </div>
    </div>
    <div class="form-row">
      <div class="form-group col-md-12">
	<label for="destdescr">Description:</label>&nbsp;&nbsp;<b><%= destdescr %></b>  
      </div>
    </div>

 
    <div class="form-row">
      <div class="form-group col-md-6">
	<label for="desttype">New Plate Set Type:</label>&nbsp;&nbsp;<b><%= desttype %> </b> 
      </div>
      <div class="form-group col-md-6">
	<label for="destformat">Format:&nbsp&nbsp<b><%= destformat %></b>&nbsp&nbsp well</label>
      </div>
    </div>


 <div class="form-row">
 <div class="form-group col-md-6">
   <label for="destsamprep">Sample Replication:</label>&nbsp&nbsp<b><%= destsamprep %></b>
  </div>
 <div class="form-group col-md-6">
   <label for="desttargrep">Target Replication:</label>&nbsp&nbsp<b><%= desttargrep %></b>
 </div>
</div>

 <div class="form-row">
 <div class="form-group col-md-6">
   <label for="newnplates">Number of plates:</label>&nbsp&nbsp<b><%= destnplates %></b>
  </div>
</div>

 
 <div class="form-row">
 <div class="form-group col-md-12">
   <label for="destlyttxt">Sample Layout:</label>&nbsp&nbsp<b><%= destlyttxt %></b>
  </div>
</div>


  <div class="form-row">
 <div class="form-group col-md-12">
   <label for="desttrglyt">Optional target Layout:</label>&nbsp&nbsp<select name="desttrglyt" id="desttrglyt"  class="custom-select" ><%= desttargetlyts %></select>
  </div>
</div>

 
<input type="hidden" id="srcpsid" name="srcpsid" value=<%= srcpsidq %>>
<input type="hidden" id="destname" name="destname" value=<%= destnameq %>>
<input type="hidden" id="destdescr" name="destdescr" value=<%= destdescrq %>>
<input type="hidden" id="desttype" name="desttype" value=<%= desttypeq %>>
<input type="hidden" id="destformat" name="destformat" value=<%= destformatq %>>
<input type="hidden" id="destsamprep" name="destsamprep" value=<%= destsamprepq %>>
<input type="hidden" id="desttargrep" name="desttargrep" value=<%= desttargrepq %>>
<input type="hidden" id="srclytid" name="srclytid" value=<%= srclytidq %>>
<input type="hidden" id="srcnplates" name="srcnplates" value=<%= srcnplatesq %>>
<input type="hidden" id="destlytid" name="destlytid" value=<%= destlytidq %>>


<input type="submit" class="btn btn-primary" value="Submit">
</form> 
</div>

<script src=""></script>

<@include footer.tpl %>

 
