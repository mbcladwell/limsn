<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
         <@include header.tpl %>
  
  <div class="container">
  <h1>Import Data for PS-<%= psid %></h1>
  
    <br>
    <form action="impassdatadb" method="POST">
      <div class="form-row">
	<div class="form-group col-md-12">
	  <label for="ps-description">Plate set description:&nbsp;<b><%= ps-descr %></b></label>
	</div>
      </div>
      <div class="form-row">
	<div class="form-group col-md-6">
	  <label for="format">Format:&nbsp <b> <%= format %></b></label>
	</div>
	<div class="form-group col-md-6">
	  <label for="numplates">Number of plates:&nbsp<b><%= num-plates %></b></label>	  
	</div>
      </div>


  <!-- ComboItem[] algorithmTypes = new ComboItem[]{ new ComboItem(4,">0% enhanced"), new ComboItem(3,"mean(background) + 3SD"), new ComboItem(2,"mean(background) + 2SD"), new ComboItem(1,"Top N")}; -->
 
 
      <div class="form-row">
	<div class="form-group col-md-6">
	  <label for="layout">Plate Layout:&nbsp<b><%= lyt-txt %></b></label>&nbsp&nbsp&nbsp
	</div>
	<div class="form-group col-md-6">   
	  <label for="contolsloc">Control location:&nbsp<b><%= control-loc %></b></label>&nbsp&nbsp&nbsp   
	</div>
      </div>
      <div class="form-row">
	<div class="form-group col-md-12">
	  <label for="layout">Data file name:&nbsp<b><%= filename %></b></label>&nbsp&nbsp&nbsp
	</div>
      </div>

 
      <div class="form-row">
	<div class="form-group col-md-6">
	  <label for="lytname">Assay Run Name</label>
	  <input type="text" class="form-control" id="assayname" name="assayname" placeholder="Enter assay name">
	</div>

    
	<div class="form-group col-md-6">
	  <label for="descr">Assay Run Description</label>
	  <input type="text" class="form-control" id="assay-descr" name="assay-descr" placeholder="Enter assay description">
	</div>
      </div>
      <div class="form-row">	
	<div class="form-group col-md-6">
	  <label for="assay-type">Assay type:</label>
	  <select class="custom-select" id="assay-type" name="assay-type">
	    <option selected>Choose...</option>
	    <option value="ELISA">ELISA</option>
	    <option value="Octet">Octet</option>
	    <option value="SNP">SNP</option>
	    <option value="HCS">HCS</option>
	    <option value="HTRF">HTRF</option>
	    <option value="FACS">FACS</option>
	  </select>
	</div>
	<div class="form-group col-md-6">
	  <label for="algorithm">Auto Hit Selection Algorithm:</label>
	  <select class="custom-select" id="algorithm" name="algorithm" onchange="algSelection(event)">
	    <option value="0" selected>None</option>
	    <option value="1">Top N</option>
	    <option value="2">mean(background) + 2SD</option>
	    <option value="3">mean(background) + 3SD</option>
	    <option value="4">>0% enhanced</option>
	  </select>
	</div>
      </div>
      <div class="form-row">
	<div class="form-group col-md-6">
	  <label for="hlname" id="labelhlname" name="labelhlname">Hit List Name</label>
	  <input type="text" class="form-control" id="hlname" name="hlname" placeholder="">
	</div>
	<div class="form-group col-md-6">
	  <label for="hldescr" id="labelhldescr" name="labelhldescr">Hit List Description</label>
	  <input type="text" class="form-control" id="hldescr" name="hldescr" placeholder="">
	</div>
      </div>


            <div class="form-row">
	<div class="form-group col-md-6">
	</div>
	<div class="form-group col-md-6">
	  <label for="nhits" id="labelnhits" name="labelnhits">Number of desired hits:</label>
	  <input type="text" class="form-control" id="nhits" name="nhits" placeholder="">
	</div>
      </div>

      <input type="hidden" id="format" name="format" value=<%= format %>>
      <input type="hidden" id="lytsysname" name="lytsysname" value=<%= lyt-sys-name %>>
      <input type="hidden" id="controlloc" name="controlloc" value=<%= control-loc %>>
      <input type="hidden" id="numplates" name="numplates" value=<%= num-plates %>>
      <input type="hidden" id="filename" name="filename" value=<%= filename %>>
      <input type="hidden" id="psid" name="psid" value=<%= psid %>>
      <input type="hidden" id="ps-descr" name="ps-descr" value=<%= ps-descr %>>
      <input type="hidden" id="datafile" name="datafile" value=<%= temp-file %>>
      
      
      <div class="form-row">
	<input  class="btn btn-primary" id="importButton" name="importButton" type="submit" value="Import Data" onclick="myFunction()" >
      </div>
    </form> 

 <button class="btn btn-primary" type="button" id="loadingButton" name="loadingButton" enabled>
  <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true" ></span>
  Loading...
</button>


    
</div>

  <script>

    document.getElementById("hlname").disabled = true;
    document.getElementById("hldescr").disabled = true;

    function algSelection(e) {   
	switch( e.target.value) {
	case "0":
	    document.getElementById("hlname").disabled = true;
	    document.getElementById("hlname").placeholder = "";
	    document.getElementById("hldescr").disabled = true;
	    document.getElementById("hldescr").placeholder = "";
	    document.getElementById("nhits").disabled = true;
	    document.getElementById("nhits").placeholder = "";
	    break;
	case "1":
	    document.getElementById("hlname").disabled = false;
	    document.getElementById("hlname").placeholder = "Enter hit list name";
	    document.getElementById("hldescr").disabled = false;   
	    document.getElementById("hldescr").placeholder = "Enter hit list description";
	    document.getElementById("nhits").disabled = false;   
	    document.getElementById("nhits").placeholder = "Enter number of desired hits";
	    break;
	default:
	    document.getElementById("hlname").disabled = false;
	    document.getElementById("hlname").placeholder = "Enter hit list name";
	    document.getElementById("hldescr").disabled = false;   
	    document.getElementById("hldescr").placeholder = "Enter hit list description";
	    document.getElementById("nhits").disabled = true;
	    document.getElementById("nhits").placeholder = "";
	} 
    }
    
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
