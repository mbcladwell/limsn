<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <div class="container">
  <h2>Add a Plate Set To Project PRJ-<%= prjid %></h2>

  <form action="/plateset/addstep2" method="post">
 <div class="form-group">   
    <label for="name">Plate Set Name:</label>  <input type="text"  class="form-control" id="psname" name="psname" value="" required>
 </div>
 <div class="form-group">   
   <label for="descr">Description:</label>  <input type="text"  class="form-control" id="descr" name="psdescr" value="" required>
 </div>
 <div class="form-row">
 <div class="form-group  col-md-6">   
     <label for="numplates"><a href="http://labsolns.com/limsn/configuration"> Number of Plates</a>  (<%=  allowedplates %> max):</label>  <input type="text"  class="form-control"  id="numplates" name="numplates" value="" required>
 </div>
 <div class="form-group col-md-6">
   <label for="format">Plate Format:</label>
   <select name="format"  class="custom-select" id="format">
     <option value="96">96</option>
     <option value="384">384</option>
     <option value="1536">1536</option>
   </select>
 </div>
 </div>
 <div class="form-row">
   <div class="form-group col-md-6">
     <label for="type">Plate Type:</label>
     <select name="type"  class="custom-select" id="type" onchange="typeSelection(event)"> <%= plate-types %></select> 
   </div>
 </div>
 

 <div class="form-row">
     <div class="form-group col-md-6">
	 <input type="submit"  class="btn btn-primary" value="Submit" id="importButton" name="importButton" enabled>
     </div>
 </div>


 <input type="hidden" id="allowedplates" name="allowedplates" value=<%= allowedplatesq %>>

 
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

 /* var temp = <%= format %>;
  * var mySelect = document.getElementById('format');

  * for(var i, j = 0; i = mySelect.options[j]; j++) {
  *     if(i.value == temp) {
  *         mySelect.selectedIndex = j;
  *         break;
  *     }
  * } */
    
</script>




<@include footer.tpl %>

