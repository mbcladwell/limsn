<!-- hitlist#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
<div class="container">
  <h1>Hit Lists for AR-<%= id %></h1>
<table id="hltable"  class=" table table-striped table-bordered"><thead><tr><th>Hit List</th><th>Name</th><th>Description</th><th>N</th></tr></thead>
 <tbody> <%= body %></tbody>
</table>

</div>
<script>          
$(document).ready(function() {
    $('#hltable').DataTable();
} );
  

</script>


<@include footer.tpl %>
