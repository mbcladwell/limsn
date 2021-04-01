<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>
<div class="container">
  <h1>Registration</h1><br><br>

Registration <label style="color:red">failed</label>.<br>
Customer id and license key do not match.<br><br>

Customer ID:&nbsp;<%= cust-id %><br><br> 
License key:&nbsp;<%= cust-key %><br><br> 
Email:&nbsp;<%= email %><br><br> 
  
  </div>
<@include footer.tpl %>

