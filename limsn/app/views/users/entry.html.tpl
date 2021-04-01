<!-- user#add view template of postest
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<html>
  <head>
    <title><%= (current-appname) %>
    </title>
    
  

  </head>
  <body>
    <h1>lnuser#entry</h1>
    <p>Rendered from app/views/lnuser/entry.html.tpl.</p>

   <form action="/add" method="post" enctype="text">
   <input type="text" id="lnuser" name="lnuser"><br>
   <input type="password" id="passwd" name="passwd"><br>
    <input type="submit" value="Add to database">
    </form>

    
  </body>
</html>
