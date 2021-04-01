<!-- plateset#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis.
 -->

<@include header.tpl %>
  <div class="container">
      <form id="edit_psform">

  <div class="row">
    <div class="col">
      <h2>Plate Sets for PRJ-<%= prjid %></h2>
    </div>  
    <div class="col">
     <div class="dropdown dropright">
    <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-tools" viewBox="0 0 16 16">
  <path d="M1 0L0 1l2.2 3.081a1 1 0 0 0 .815.419h.07a1 1 0 0 1 .708.293l2.675 2.675-2.617 2.654A3.003 3.003 0 0 0 0 13a3 3 0 1 0 5.878-.851l2.654-2.617.968.968-.305.914a1 1 0 0 0 .242 1.023l3.356 3.356a1 1 0 0 0 1.414 0l1.586-1.586a1 1 0 0 0 0-1.414l-3.356-3.356a1 1 0 0 0-1.023-.242L10.5 9.5l-.96-.96 2.68-2.643A3.005 3.005 0 0 0 16 3c0-.269-.035-.53-.102-.777l-2.14 2.141L12 4l-.364-1.757L13.777.102a3 3 0 0 0-3.675 3.68L7.462 6.46 4.793 3.793a1 1 0 0 1-.293-.707v-.071a1 1 0 0 0-.419-.814L1 0zm9.646 10.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708zM3 11l.471.242.529.026.287.445.445.287.026.529L5 13l-.242.471-.026.529-.445.287-.287.445-.529.026L3 15l-.471-.242L2 14.732l-.287-.445L1.268 14l-.026-.529L1 13l.242-.471.026-.529.445-.287.287-.445.529-.026L3 11z"/>
</svg>
    </button>
    <div class="dropdown-menu">
	<a class="dropdown-item" href="#" onclick="addPlateSet()">Add to PRJ-<%= prjid %></a>
	<a class="dropdown-item" href="#" onclick="editPlateSet()">Edit</a>
     <a class="dropdown-item" href="#" onclick="groupPlateSet()">Group</a>
     <a class="dropdown-item" href="#" onclick="reformatPlateSet()">Reformat</a>
     <a class="dropdown-item" href="#" onclick="worklist()">Worklist</a>
     <div class="dropdown-header">Import</div> 
      <a class="dropdown-item" href="#"  onclick="importPlateSetData()">Assay Data</a>
      <a class="dropdown-item" href="#" onclick="importaccs()">Accessions</a>
      <a class="dropdown-item" href="#" onclick="importbc()">Barcodes</a>
       
     
    </div>
  </div>
    </div> <div class="col"></div>
    </div>  
  <table id="pstable" class="table table-striped table-bordered"><thead><tr><th><img src="../img/checkmark.png" height="20" width="20"></th><th>Plate Set</th><th>Name</th><th>Description</th><th>Type</th><th>Count</th><th>Format</th><th>Layout ID</th><th>Sample Replicates</th><th>Worklists</th></tr></thead>
  <tbody>  <%= body %> </tbody>
</table>

<input type="hidden" name="prjid" id="prjid" value=<%=  prjidq %>/>

</form>
<br>

<hr>

<h2>Assay Runs for PRJ-<%= prjid %></h2>

<table id="artable" class="table table-striped table-bordered"><thead><tr><th>Assay Run</th><th>Name</th><th>Description</th><th>Type</th><th>Layout</th><th>Layout Name</th></tr></thead>
  <tbody><%= assay-runs %></tbody>
</table>



<br>
<hr>
<h2>Hit Lists for PRJ-<%= prjid %></h2>
<table id="hltable" class="table table-striped table-bordered"><thead><tr><th>Assay Run</th><th>AR Name</th><th>Assay Type</th><th>Hit List</th><th>HL Name</th><th>Description</th><th>Number of Hits</th></tr></thead>
    <tbody>
	<%= hit-lists %>
    </tbody>
</table>


<script>   

function addPlateSet(){
        var str = "/plateset/add?format=96&type=master&prjid=";
        var res = str.concat( <%= prjid %> );
     var f = document.getElementById("edit_psform");
     console.log(res);
	f.setAttribute("action", res);
	f.setAttribute("method", "GET");	
	f.submit(); return false;    
 }


 
 $(document).ready(function() {
     $('#pstable').DataTable({
         dom: 'lBfrtip',
         buttons: [
             'copyHtml5',
             'excelHtml5',
             'csvHtml5',
             'pdfHtml5'
         ]
     } );
 } );

 $(document).ready(function() {
     $('#artable').DataTable({
         dom: 'lBfrtip',
         buttons: [
             'copyHtml5',
             'excelHtml5',
             'csvHtml5',
             'pdfHtml5'
         ]
     } );
 } );

 $(document).ready(function() {
     $('#hltable').DataTable({
         dom: 'lBfrtip',
         buttons: [
             'copyHtml5',
             'excelHtml5',
             'csvHtml5',
             'pdfHtml5'
         ]
     } );
 } );

</script>

</div>
 
<@include footer.tpl %>
