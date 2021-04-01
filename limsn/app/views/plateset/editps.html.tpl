<!-- project#edit view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <div class="container">
  <h1>Edit Plate Set PS-<%= psid %></h1><br><br>

  <form action="/plateset/editaction">
    <div class="form-group">
      <label for="name">Plate Set Name:</label>  <input type="text" class="form-control" id="psname" name="psname" value= <%= name %> > 
</div>

<div class="form-group">
<label for="descr">Description:</label>  <input type="text" class="form-control" id="descr" name="descr" value= <%= descr %> > 
</div>
<input id="psid" name="psid" type="hidden" value=<%= psid %>>


<button type="submit" class="btn btn-primary">Submit</button>
</form> 
  </div>
<@include footer.tpl %>
