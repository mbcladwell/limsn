<!-- 
   select.js puts an event listener on "myfile" and validates the file
Then submit must be pressed to process
   <input type="hidden" id="" name="outfile" value=  >
           -->

<@include header.tpl %>
  <div class="container">
    <h2>Select Barcode ID File For Import into PS-<%= psid %> </h2><br>

	<label >Plate Set Name:&nbsp<b><%= psname %></b></label><br>
	<label>Description:&nbsp<b><%= descr %></b></label><br>
	<br><br>
   

    <form action="/plateset/impbcaction" method="POST">
      <div>
	<label for="myfile">Select barcode file for import.</label><br>
	<label for="myfile">The file must be tab delimitted text with a header.</label><br>
	<label for="myfile"> PS-<%= psid %> contains <%= num-plates %> plates requiring <%= num-plates %> rows of data.</label><br>
	
	<label for="myfile">Required file format:</label>
      </div>

      <pre>plate	barcode.id
1	LN000001
2	LN000002
3	LN000003 ....</pre>
      
      <div class="custom-file">
	<input type="file" accept=".txt" class="custom-file-input" id="myfile" name="myfile">
	<label class="custom-file-label" for="myfile">Choose file</label>
      </div><br><br>
      <button type="submit" class="btn btn-primary">Submit</button><br>      
      <input type="hidden" id="datatransfer" name="datatransfer" >
      <input type="hidden" id="psid" name="psid" value=<%= psidq %>>
      <input type="hidden" id="num-plates" name="num-plates" value=<%= num-platesq %>>
      <input type="hidden" id="psname" name="psname" value=<%= psnameq %>>
      <input type="hidden" id="descr" name="descr" value=<%= descrq %>>
      
      
    </form>

    <span id="myText"></span>
     

    <script>
      $('#myfile').on('change',function(){
          //get the file name
          var fileName = $(this).val();
          //replace the "Choose a file" label
          $(this).next('.custom-file-label').html(fileName);
      })
    </script>

</div>
  
<script src="impbc.js"></script>
  
  
<@include footer.tpl %>

