<!-- 
   select.js puts an event listener on "myfile" and validates the file
Then submit must be pressed to process
   <input type="hidden" id="" name="outfile" value=  >
           -->

<@include header.tpl %>
  <div class="container">
    <h1>Select Layout For Import</h1><br>

    <form action="/viewlayout" method="POST">
      <div>
	<label for="myfile">Select a layout file for import.</label><br>
	<label for="myfile">The file must be tab delimitted text with a header and contain 96, 384, or 1536 rows of data.</label><br>
	<label for="myfile">Required format:</label>
      </div>

      <pre>well	type
1	5
2	5
3	5
4	5 ....</pre>
      
      <div class="custom-file">
	<input type="file" accept=".txt" class="custom-file-input" id="myfile" name="myfile">
	<label class="custom-file-label" for="myfile">Choose file</label>
      </div><br><br>
      <button type="submit" class="btn btn-primary">Submit</button><br>      
      <input type="hidden" id="datatransfer" name="datatransfer" >
      <input type="hidden" id="format2" name="format2" >
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
  
<script src="select.js"></script>
  
  
<@include footer.tpl %>

