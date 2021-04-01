<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <h1>View Layout</h1><br><br>

  <form action="/layout/import?id=id$value">

 <label for="myfile">Select import layout file:</label>
<input type="file" id="myfile" name="myfile"> 
<br><br>
  <input type="submit" value="Submit">
</form> 
  
<@include footer.tpl %>

