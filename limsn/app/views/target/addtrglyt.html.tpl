<!-- hitlist#getid view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<@include header.tpl %>
  <div class="container"> 
    <h3>Add Target Layout</h3><br>

    <form action="/addtrglytaction" method="get">
	<div class="container">
	    <div class="row">
		<div class="col">
		    <div class="form-group">
			<label for="tname">Target Layout Name:</label>
			<input type="text" id="tname" class="form-control" name="tlytname">
		    </div>
		</div>
		<div class="col">
		    <div class="form-group">
			<label for="prj">Project:</label>
			<select name="projects" class="form-control" id="projects"><%= all-projects %> </select>
		    </div>
		</div>
	    </div>
	    
	    <div class="row">
		<div class="col">    
		    <div class="form-group">
			<label for="desc">Description:</label><input type="text" id="desc" class="form-control" name="desc"> 
		    </div>
		</div>
		<div class="col">        
		    <div class="form-group">
			<label for="reps">Replication:</label><select name="reps" id="reps"  class="form-control" onchange="repSelection(event)">
			    <option value="1">1</option>  
			    <option value="2">2</option>
			    <option value="4">4</option>
			</select>
		    </div>
		</div> 
	    </div>
 <hr>
	<label for="">Indicate quadrant contents:</label>

  <div class="row">
    <div class="col">
      <div class="form-group"><label for="t1" id="q1">Quadrant 1:</label><select name="t1" class="form-control" id="t1"> <%= all-targets %></select></div>
    </div>
    <div class="col">
      <div class="form-group"><label for="t2" id="q2">Quadrant 2:</label><select name="t2" class="form-control" id="t2"> <%= all-targets %></select></div>
    </div>
  </div>

  <div class="row">
    <div class="col">    
      <div class="form-group"><label for="t3" id="q3">Quadrant 3:</label><select name="t3" class="form-control" id="t3"> <%= all-targets %></select></div>
    </div>  
    <div class="col">        
      <div class="form-group"><label for="t4" id="q4">Quadrant 4:</label><select name="t4" class="form-control" id="t4"> <%= all-targets %></select></div>
    </div>
  </div>
  <div>
    <button class="btn btn-primary">Submit</button>
  </div>
      </div>
    </form>

<script src="addtrglyt.js"></script>


<@include footer.tpl %>
