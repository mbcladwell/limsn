<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <h1>View/Import Layout</h1><br><br>
  
  
  <p><h3>Sample Layout</h3></p>
<image src= <%= spl-out2 %>> 
<br><br>

<%= format %>

<form action="updatedb">
<b> <p id="toi"></p></b>
  <input type="submit" value="Yes" >  
</form> 


<form action="/projects/getall"> 
<input type="submit" value="Cancel">
</form>  

  <script src="/app/views/layout/upload.js"></script>
<@include footer.tpl %>

