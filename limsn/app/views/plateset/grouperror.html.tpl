<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <h1>Error!</h1><br><br>

When grouping Plate Sets, all plate set formats and layouts must be the same.

Formats equal: <%= format-equal? =%>

Layouts equal: <%= layout-equal? =%>

  
<@include footer.tpl %>

