<!-- hitlist#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>



  <div class="container">
    <h3>Bulk Target Upload</h3>

    Import a tab delimitted, 4 column file with header:<br><br>
<pre>
project	target	description	accession
1	DYSF		8291
1	FKRP		79147
1	LAMA2		3908
1	TGFB2		7042
1	FSHMD1B		2490
1	SYNE1		23345
.
.
.
</pre>

Description is optional. Note that in the above example there are 2 tabs between the target and accession to signify that the description is empty e.g. the first row is:<br><br>
<pre>1&#60;tab>DYSF&#60;tab>&#60;tab>8291<br></pre>

The file must end on the last row of data i.e. no final carriage return.<br>
      
    <form action="/addbulkaction" method="post">
      
      <div class="custom-file">
	<input type="file" class="custom-file-input" accept=".txt, .csv" id="myfile">
	<label class="custom-file-label" for="customFile" >Choose bulk target upload file</label>
      </div><br><br>
      
      <div>
	  <button  type="submit" class="btn btn-primary">Submit</button>
      </div>
      <input type="hidden" id="datatransfer" name="datatransfer" >
      <input type="hidden" id="hitcount" name="hitcount" >
      
    </form>
    <span id="myText"></span>
    

  </div>


  <script>
   document.querySelector('.custom-file-input').addEventListener('change',function(e){
       var fileName = document.getElementById("myfile").files[0].name;
       var nextSibling = e.target.nextElementSibling
       nextSibling.innerText = fileName
   })

  </script>

  
  <script src="showfile.js"></script>


<@include footer.tpl %>
