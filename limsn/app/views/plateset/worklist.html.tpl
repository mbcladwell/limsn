<!-- plateset#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis.
 -->

<@include header.tpl %>
  <div class="container">
 
      <h2>Worklist for PS-<%= psid %></h2>
      
    <table id="wltable" class="table table-striped table-bordered"><thead><tr><th>Sample ID</th><th>Source Plate</th><th>Source Well</th><th>Destination Plate</th><th>Destination Well</th></tr></thead>
  <tbody>  <%= body %> </tbody>
</table>

<input type="hidden" name="prjid" id="prjid" value=<%= prjidq %>/>


<script>   

 
 $(document).ready(function() {
     $('#wltable').DataTable({
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
