<!-- project#edit view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>
 <div class="container">
 
  <h1>Edit Project PRJ-<%= prjid %></h1><br><br>

  <form action="/project/editaction">
    <div class="form-group">
      <label for="name">Project Name:</label>  <input type="text" class="form-control" id="pname" name="pname" value= <%= name %> > 
</div>

<div class="form-group">
<label for="descr">Description:</label>  <input type="text" class="form-control" id="descr" name="descr" value= <%= descr %> > 
</div>
<input id="prjid" name="prjid" type="hidden" value=<%= prjid %>>


<button type="submit" class="btn btn-primary">Submit</button>
</form> 
 </div> 
<@include footer.tpl %>
