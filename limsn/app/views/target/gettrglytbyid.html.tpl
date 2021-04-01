<!-- hitlist#getid view template of lnserver
     Please add your license header here.
     This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
<div class="container">
    
  <h3>
  Targets for Target Layout <%= trg-lyt-sys-name %></h3>
  <h5>
  Name: <%= trg-lyt-name %><br><br>
  Description: <%= trg-lyt-descr %><br><br>
  Replication: <%= reps %><br><br>
  </h5>
<table id="tlytidtable" class="table table-striped table-bordered"><thead><tr><th>ID</th><th>Project</th><th>Name</th><th>Quadrant</th><th>Description</th><th>Accession ID</th></tr></thead>
  <tbody><%= body %></tbody>
</table>
</div>
<script>
$(document).ready(function() {
    $('#tlytidtable').DataTable()}); 
</script>



<@include footer.tpl %>
