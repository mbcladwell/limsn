<!-- assayrun#getforpsid view template of lnserver
     Please add your license header here.
     This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
<div class="container">
    <form  id="vhits_form">
	<div class="row">
	    <div class="col">
		<h2>Assay Run AR-<%= arid %></h2>
	    </div>
	    <div class="col">
		<div class="dropdown dropright">
		    <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-tools" viewBox="0 0 16 16">
			    <path d="M1 0L0 1l2.2 3.081a1 1 0 0 0 .815.419h.07a1 1 0 0 1 .708.293l2.675 2.675-2.617 2.654A3.003 3.003 0 0 0 0 13a3 3 0 1 0 5.878-.851l2.654-2.617.968.968-.305.914a1 1 0 0 0 .242 1.023l3.356 3.356a1 1 0 0 0 1.414 0l1.586-1.586a1 1 0 0 0 0-1.414l-3.356-3.356a1 1 0 0 0-1.023-.242L10.5 9.5l-.96-.96 2.68-2.643A3.005 3.005 0 0 0 16 3c0-.269-.035-.53-.102-.777l-2.14 2.141L12 4l-.364-1.757L13.777.102a3 3 0 0 0-3.675 3.68L7.462 6.46 4.793 3.793a1 1 0 0 1-.293-.707v-.071a1 1 0 0 0-.419-.814L1 0zm9.646 10.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708zM3 11l.471.242.529.026.287.445.445.287.026.529L5 13l-.242.471-.026.529-.445.287-.287.445-.529.026L3 15l-.471-.242L2 14.732l-.287-.445L1.268 14l-.026-.529L1 13l.242-.471.026-.529.445-.287.287-.445.529-.026L3 11z"/>
			</svg>
		    </button>
		    <div class="dropdown-menu">
			<a class="dropdown-item" href="#"  onclick="viewhits()">View Hits</a>

		    </div>
		</div>
	    </div> 
	    <input type="hidden" id="infile" name="infile" value=<%= infileq %>>
	    <input type="hidden" id="infile2" name="infile2" value=<%= infile2q %>>
	    <input type="hidden" id="hitfile" name="hitfile" value=<%= hitfileq %>>
	    <input type="hidden" id="arid" name="arid" value=<%= aridq %>>
	    <input type="hidden" id="response" name="response" value=<%= responseq %>>
	    <input type="hidden" id="threshold" name="threshold" value=<%= thresholdq %>>
	    <input type="hidden" id="numhits" name="numhits" value=<%= numhitsq %>>

	</div>
    </form>
  <table id="artable" class="display table table-striped table-bordered"><thead><tr><th>Assay Run</th><th>Name</th><th>Description</th><th>Type</th><th>Layout</th><th>Layout Name</th></tr></thead>
    <tbody><%= body %></tbody>
  </table>
<div class="row">
<img src=<%= outfile2 %> align="left">
</div>
<form action="/assayrun/replot" method="POST" >

  <div class="row">
    <div class="col">
      <div class="form-group">
	<label for="response">Response:</label><select name="response"  class="form-control" id="response">
	  <option value="0">Background Subtracted</option>
	  <option value="1">Normalized</option>
	  <option value="2">Normalized to Positive Controls</option>
	  <option value="3">% enhanced</option>
	</select>
      </div>
    </div>
    <div class="col">
      <div class="form-group">
	<label for="threshold">Threshold - algorithmic:</label><select name="threshold"  class="form-control" id="threshold">
	  <option value="1">mean(pos)</option>
	  <option value="2">mean(neg) + 2SD</option>
	  <option value="3">mean(neg) + 3SD</option>
	</select>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col">
  <input type="submit"  class="btn btn-primary" value="Replot">
    </div>
    <div class="col">
      <div class="form-group">
	  <label for="manthreshold">OR manually enter:</label><input type="text" id="manthreshold" name="manthreshold">
      </div>
    </div>      
  </div>

  <input type="hidden" id="infile" name="infile" value=<%= infileq %>>
  <input type="hidden" id="infile2" name="infile2" value=<%= infile2q %>>
  <input type="hidden" id="hitfile" name="hitfile" value=<%= hitfileq %>>
  <input type="hidden" id="arid" name="arid" value=<%= aridq %>>
  <input type="hidden" id="bodyencode" name="bodyencode" value=<%= body-encodeq %>>
  <input type="hidden" id="hitlistsencode" name="hitlistsencode" value=<%= hit-lists-encodeq %>>
  <input type="hidden" id="response" name="response" value=<%= responseq %>>
  <input type="hidden" id="threshold" name="threshold" value=<%= thresholdq %>>

  
</form>
<hr>
<h2>Hit Lists for AR-<%= arid %></h2>
<table id="hltable" class="display table table-striped table-bordered"><thead><tr><th>Assay Run</th><th>AR Name</th><th>Assay Type</th><th>Hit List</th><th>HL Name</th><th>Description</th><th>Number of Hits</th></tr></thead>
<tbody><%= hit-lists %></tbody>
</table>


</div>

<script>

 function viewhits(){
     if( <%= numhitsq %> == "0" ){
	 var str1="A threshold of ";
	 var str2=str1.concat(<%=  thresholdq  %>);
	 var str3=str2.concat(" results in 0 hits!");
	 window.alert(str3);
     } else {
	 var f = document.getElementById("vhits_form");
	 f.setAttribute("action", "/hitlist/viewhits");
	 f.setAttribute("method", "POST");	
	 f.submit(); return false;
     }
 }	
 

 
 $(document).ready(function() {
     $('#artable').DataTable();
} );
  
  
$(document).ready(function() {
    $('#hltable').DataTable();
} );

</script>

<@include footer.tpl %>
