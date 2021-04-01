<!-- plate#getid view template of lnserver
     Please add your license header here.
     This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
<div class="container">
    <h2>Data for AR-<%= arid %></h2>
    <table id="datatable" class="table table-striped table-bordered">
	<thead><tr><th>Assay Run</th><th>Plate Set</th><th>Name</th><th>Order</th><th>Well</th><th>Type</th><th>WellNum</th><th>Response</th><th>BkgrndSub</th><th>Norm</th><th>NormPos</th><th>%Enhanced</th><th>Sample</th><th>SplAccs</th><th>Target</th><th>TrgAccs</th></tr></thead>
	<tbody><%= body %></tbody>
    </table>
</div>


<script>   
   $(document).ready(function() {
       $('#datatable').DataTable({
        dom: 'lBfrtip',
        buttons: [
            'copyHtml5',
            'excelHtml5',
            'csvHtml5',
            'pdfHtml5'
        ]
    });
 } );

</script>

<@include footer.tpl %>
