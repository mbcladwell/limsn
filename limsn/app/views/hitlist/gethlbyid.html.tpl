<!-- hitlist#getid view template of lnserver
     Please add your license header here.
     This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
<div class="container">
    <form  id="hl_form">

	<div>
	<h2>Hits for HL-<%= hlid %></h2>
	<label>Number of hits: <%=  numhits  %></label>
  	<table id="hltable" class="table table-striped table-bordered">
	    <thead><tr><th>Name</th><th>Project</th><th>Accession</th></tr></thead>
	    <tbody> <%= body %></tbody>
	</table>
    </div>
    <hr>
	<div>
 <div class="row">
     <div class="col">
	 <h2>Hit availability</h2>
     </div>
     <div class="col">
	 <div class="dropdown dropright">
	     <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
		 <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-tools" viewBox="0 0 16 16">
		     <path d="M1 0L0 1l2.2 3.081a1 1 0 0 0 .815.419h.07a1 1 0 0 1 .708.293l2.675 2.675-2.617 2.654A3.003 3.003 0 0 0 0 13a3 3 0 1 0 5.878-.851l2.654-2.617.968.968-.305.914a1 1 0 0 0 .242 1.023l3.356 3.356a1 1 0 0 0 1.414 0l1.586-1.586a1 1 0 0 0 0-1.414l-3.356-3.356a1 1 0 0 0-1.023-.242L10.5 9.5l-.96-.96 2.68-2.643A3.005 3.005 0 0 0 16 3c0-.269-.035-.53-.102-.777l-2.14 2.141L12 4l-.364-1.757L13.777.102a3 3 0 0 0-3.675 3.68L7.462 6.46 4.793 3.793a1 1 0 0 1-.293-.707v-.071a1 1 0 0 0-.419-.814L1 0zm9.646 10.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708zM3 11l.471.242.529.026.287.445.445.287.026.529L5 13l-.242.471-.026.529-.445.287-.287.445-.529.026L3 15l-.471-.242L2 14.732l-.287-.445L1.268 14l-.026-.529L1 13l.242-.471.026-.529.445-.287.287-.445.529-.026L3 11z"/>
		 </svg>
	     </button>
	     <div class="dropdown-menu">
		 <a class="dropdown-item" onclick="editRearray()">Rearray</a>
	     </div>
	 </div>
     </div> 
 </div>  
 
 <label>Hit List HL-<%= hlid %> has <%= numhits %> hits total</label>
  	<table id="hlavail" class="table table-striped table-bordered">
	    <thead><tr><th><img src="../img/checkmark.png" height="20" width="20"></th><th>ID</th><th>Plate Set</th><th>Type</th><th>Format</th><th>Count</th></tr></thead>
	    <tbody> <%= body2 %></tbody>
	</table>
	</div>

	<input type="hidden" id="prjid" name="prjid" value=<%= prjidq %>>
	<input type="hidden" id="sid" name="sid" value=<%= sidq %>>
	<input type="hidden" id="hlid" name="hlid" value=<%= hlidq %>>
	<input type="hidden" id="numhits" name="numhits" value=<%= numhitsq %>>

    </form>


    
</div>




<script>

 function editRearray(){
     if(getCheckedBoxes("psid") == null || getCheckedBoxes("psid").length > 1 ){
	window.alert("Please select a hit list to rearray!");}
     else {
	 var f = document.getElementById("hl_form");
	 f.setAttribute("action", "/hitlist/rearray");
	f.setAttribute("method", "POST");	
	f.submit(); return false;
     }	
    }

     
     $(document).ready(function() {
	 $('#hltable').DataTable({
         dom: 'lBfrtip',
         buttons: [
             'copyHtml5',
             'excelHtml5',
             'csvHtml5',
             'pdfHtml5'
         ]
     });
 });


 $(document).ready(function() {
     $('#hlavail').DataTable({
         dom: 'lBfrtip',
         buttons: [
             'copyHtml5',
             'excelHtml5',
             'csvHtml5',
             'pdfHtml5'
         ]
     });
 });

</script>



<@include footer.tpl %>
