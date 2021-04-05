<!-- layout#lytbyid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
<@include header.tpl %>

  <div class="container">
  <h2>Plate Layouts for Source LYT-<%= lytid %></h2>
<table id="lyttable" class="display table table-striped table-bordered"><thead><tr><th>ID</th><th>Name</th><th>Description</th><th>Format</th><th>Sample N</th><th>Target N</th><th>Edge?</th><th>N Controls</th><th>Unk N</th><th>Location</th><th>src/dest</th></tr></thead>

 <tbody> <%= body %></tbody>
</table>

<p><h3>Sample Layout</h3></p>
<p><img src=<%= spl-out2 %>></p>
<p><h3>Sample Replication</h3></p>

<p><img src=<%= spl-rep-out2 %>></p>

<p><h3>Target Replication</h3></p>

<p><img src=<%= trg-rep-out2 %>><p>
</div>


      <script>          
$(document).ready(function() {
    $('#lyttable').DataTable()});

</script>

<@include footer.tpl %>
