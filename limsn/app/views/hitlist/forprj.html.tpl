<!-- plateset#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis.
 -->

<@include header.tpl %>
  <div class="container">
   
<h2>Hit Lists for PRJ-<%= prjid %></h2>
<table id="hltable" class="table table-striped table-bordered"><thead><tr><th>Hit List</th><th>HL Name</th><th>Description</th><th>Number of Hits</th></tr></thead>
    <tbody>
	<%= body %>
    </tbody>
</table>

</div>

<script>   

 
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

 
<@include footer.tpl %>
