<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <div class="container">
  <h2>Add a Plate Set To Project PRJ-<%=  prjid %> (Contd)</h2>

  <form action="/plateset/addaction" method="post">
 <div class="form-group">   
     <label for="name">Plate Set Name:</label><b>&nbsp;&nbsp; <%=  psname %></b>
 </div>
 <div class="form-group">   
     <label for="descr">Description:</label> <b>&nbsp;&nbsp; <%=  psdescr %></b>
 </div>
 <div class="form-row">
 <div class="form-group  col-md-6">   
     <label for="numplates">Number of Plates:</label> <b>&nbsp;&nbsp; <%=  numplates %></b>
 </div>
     <div class="form-group col-md-6">
	 <label for="format">Plate Format:</label><b>&nbsp;&nbsp; <%=  format %></b>
 </div>
 </div>
 <div class="form-row">
   <div class="form-group col-md-6">
       <label for="type">Plate Type:</label> <b>&nbsp;&nbsp; <%=  plttype %></b>
   </div>
 </div>

 <div class="form-row">    
     <div class="form-group col-md-6">
     <label for="samplelyt">Sample Layout:</label> 
     <select name="samplelyt"  class="custom-select" id="samplelyt"> <%= sample-layouts %> </select>
     </div>
     <div class="form-group col-md-6">
	 <label for="trglyt">Target Layout:</label> &nbsp;&nbsp;&nbsp;   <label for="target-desc"><%= trg-desc %></label> 
	 <select class="custom-select" id="trglyt" name="trglyt"> <%= target-layouts %> </select>
	 
	 <div>	 
     </div>
     </div>
   <br>
   <div class="form-row">
       <div class="form-group col-md-6">
	   <input type="submit"  class="btn btn-primary" value="Confirm" id="importButton" name="importButton" enabled>
       </div>
   </div>

   <input type="hidden" id="prjid" name="prjid" value=<%= prjidq %>>
   <input type="hidden" id="psname" name="psname" value=<%= psnameq %>>
   <input type="hidden" id="psdescr" name="psdescr" value=<%= psdescrq %>>
   <input type="hidden" id="format" name="format" value=<%= formatq %>>
   <input type="hidden" id="plttypeid" name="plttypeid" value=<%= plttypeidq %>>
   <input type="hidden" id="numplates" name="numplates" value=<%= numplatesq %>>
   <input type="hidden" id="plttype" name="plttype" value=<%= plttypeq %>>

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

 var plttype =  document.getElementById("plttype").value;
 if(plttype === "assay"){ 
     document.getElementById('trglyt').disabled = false;
 }else{
     document.getElementById('trglyt').disabled = true;
 }

 
</script>


<@include footer.tpl %>

