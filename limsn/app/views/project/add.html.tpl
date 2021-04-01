<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>
 <div class="container">
 
  <h1>Add a Project</h1><br><br>

  <form action="/project/addaction?name=pname$value&description=descr$value">
      <div class="form-group">
	<label for="name">Project Name:</label>  <input type="text" class="form-control" id="pname" name="pname" value="">
</div>
	  <div class="form-group">
	    <label for="descr">Description:</label>  <input type="text" class="form-control" id="descr" name="descr" value="">
	    </div>
  <button type="submit" class="btn btn-primary">Submit</button>
</form> 
</div>

  
<@include footer.tpl %>

