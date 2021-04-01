<!-- hitlist#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>



  <div class="container">
    <h3>Import Hit List for AR-<%= arid %></h3>

    Import a one column file with header:<br><br>
<pre>
id
SPL-292
SPL-285
SPL-284
SPL-283
SPL-282
SPL-281
.
.
.
</pre>

      
    <form action="/hitlist/addtoar" method="post">
      
      <div class="custom-file">
	<input type="file" class="custom-file-input" accept=".txt, .csv" id="myfile">
	<label class="custom-file-label" for="customFile">Choose hit list file</label>
      </div><br><br>
      
      <div>
	  <button  type="submit" class="btn btn-primary">Submit</button>
      </div>
      <input type="hidden" id="arid" name="arid" value=<%= arid %> >
      <input type="hidden" id="datatransfer" name="datatransfer" >
      <input type="hidden" id="hitcount" name="hitcount" >
      
    </form>
  </div>

  <span id="myText"></span>

  
  <script>
   document.querySelector('.custom-file-input').addEventListener('change',function(e){
       var fileName = document.getElementById("myfile").files[0].name;
       var nextSibling = e.target.nextElementSibling
       nextSibling.innerText = fileName
   })

  </script>

  <script src="showfile.js"></script>


<@include footer.tpl %>
