<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <div class="container">

  <h1>Add a User</h1>

  <form action="/users/addaction?name=uname$value&pw=pw$value&group=group$value">
     <div class="form-group">
       <label for="name">User Name:</label>  <input type="text"  class="form-control" id="uname" name="uname" value="">
         </div>
        <div class="form-group">
	  <label for="pw">Password:</label>  <input type="text"  class="form-control" id="pw" name="pw" value="">
	    </div>
        <div class="form-group">
	  <label for="email">Email:</label>  <input type="text"  class="form-control" id="email" name="email" value="">
	    </div>
	   <div class="form-group">
  <label for="group">Group:</label>  <select name="group" id="group"  class="form-control" >
                                        <option value="admin">Administrator</option>
                                         <option value="user">User</option>
  </select>
    </div>
  <input type="submit" class="btn btn-primary" value="Submit">
</form> 

</div>

<@include footer.tpl %>

