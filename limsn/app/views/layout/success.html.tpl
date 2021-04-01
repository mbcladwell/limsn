<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <h1>Select Layout</h1><br><br>


    <input  class="btn btn-primary" id="importButton" name="importButton" type="submit" value="Import Layout" onclick="myFunction()" >  


    
<button class="btn btn-primary" type="button" id="loadingButton" name="loadingButton" enabled>
  <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true" ></span>
  Loading...
</button>

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

