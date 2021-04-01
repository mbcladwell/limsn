<!-- plate#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
  <div class="container">
      <h2>Wells for PS-<%= psid %></h2>
      <table class="display table table-striped table-bordered"><thead><tr><th>Plate Set</th><th>Plate</th><th>Plate Order</th><th>Well</th><th>Well Type</th><th>Well Order</th><th>Sample</th><th>Accession</th></tr></thead>
 <tbody> <%= body %></tbody>
</table>

<script>          
$(document).ready(function() {
     $('table.display').DataTable(
	 {
             dom: 'lBfrtip',
             buttons: [
		 'copyHtml5',
		 'excelHtml5',
		 'csvHtml5',
		 'pdfHtml5'
             ]
	 }
     );
 } );

</script>


<@include footer.tpl %>
