<!-- 
   select.js puts an event listener on "myfile" and validates the file
Then submit must be pressed to process
   <input type="hidden" id="" name="outfile" value=  >
           -->

<@include header.tpl %>
  <div class="container">
    <h2>Select Accession ID File For Import into PS-<%= psid %> </h2><br>

    <form action="/plateset/impaccsaction" method="POST">
      <div>
	<label for="myfile">Select accessions file for import.</label><br>
	<label for="myfile">The file must be tab delimitted text with a header.</label><br>
	<label for="myfile"> PS-<%= psid %> contains <%= num-plates %> plates in <%= format %> well format holding
	<%= rows-needed %> samples requiring <%= rows-needed %> rows of data.</label><br>
	
	<label for="myfile">Required file format:</label>
      </div>

      <pre>plate	well	accs.id
1	1	LKWWU1330Q
1	2	IYSPA0314U
1	3	IANYJ9074T
1	4	QVSRN0016D
1	5	ABYSX9117G ....</pre>
      
      <div class="custom-file">
	<input type="file" accept=".txt" class="custom-file-input" id="myfile" name="myfile">
	<label class="custom-file-label" for="myfile">Choose file</label>
      </div><br><br>
      <button type="submit" class="btn btn-primary">Submit</button><br>      
      <input type="hidden" id="datatransfer" name="datatransfer" >
      <input type="hidden" id="psid" name="psid" value=<%= psidq %>>
      <input type="hidden" id="num-plates" name="num-plates" value=<%= num-platesq %>>
      <input type="hidden" id="format" name="format" value=<%= formatq %>>
      <input type="hidden" id="rows-needed" name="rows-needed" value=<%= rows-neededq %>>
      
      
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
  
<script src="impdata.js"></script>
  
  
<@include footer.tpl %>

