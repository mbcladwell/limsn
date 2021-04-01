<!-- hitlist#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>

  <div class="container">

<h3>Add A Single Target</h3><br>

<form action="/addsingle" method="get">
   <div class="form-group">
  <label for="prj">Project:</label><select name="projects"  class="form-control" id="projects"><%= all-projects %> </select>
</div>

  <div class="form-group">
    <label for="tname">Target Name:</label><input type="text"  class="form-control" id="tname" name="tname">
</div>

  <div class="form-group">
<label for="desc">Description:</label><input type="text"  class="form-control" id="desc" name="desc"> 
</div>

  <div class="form-group">
<label for="accs">Accession ID:</label><input type="text"  class="form-control"   id="accs" name="accs">
</div>
<br>
 <div>
   <button  type="submit" class="btn btn-primary">Submit</button>
 </div>
</form>
</div>
<br><br>
<hr>

<div class="container">
<h3>Bulk Target Upload</h3>

<form action="/addbulk" method="post">

 

<div class="custom-file">
  <input type="file" class="custom-file-input" accept=".txt, .csv" id="customFile">
  <label class="custom-file-label" for="customFile">Choose bulk target upload file</label>
</div><br><br>

<div>
   <button  type="submit" class="btn btn-primary">Submit</button>
 </div>

</form>
</div>


<script>
  document.querySelector('.custom-file-input').addEventListener('change',function(e){
  var fileName = document.getElementById("customFile").files[0].name;
  var nextSibling = e.target.nextElementSibling
  nextSibling.innerText = fileName
})

</script>

<@include footer.tpl %>
