<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <div class="container">
  <h2>Add Hit List to AR-<%= arid %></h2>

  <form action="/hitlist/addstep2" method="post">
 <div class="form-group">   
    <label for="name">Hit List Name:</label>  <input type="text"  class="form-control" id="hlname" name="hlname" value="" required>
 </div>
 <div class="form-group">   
   <label for="descr">Description:</label>  <input type="text"  class="form-control" id="descr" name="descr" value="" required>
 </div>
 <div class="form-group">   
   <label for="descr">Number of hits:&nbsp;<%= num-hits %></label>  
 </div>
 

 <div class="form-row">
     <div class="form-group col-md-6">
	 <input type="submit"  class="btn btn-primary" value="Submit" id="importButton" name="importButton" enabled>
     </div>
 </div>


 <input type="hidden" id="arid" name="arid" value=<%= aridq %> >
 <input type="hidden" id="hitcount" name="hitcount" value=<%= num-hitsq %> >
 <input type="hidden" id="datatransfer" name="datatransfer" value= <%= datatransferq %>>

 
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

