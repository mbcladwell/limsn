<!-- test#logtest view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis.

   
 -->

<html>
  <head>
    <title>Login test page
    </title>
    

  </head>
  <body>
    <h1>test#logtest</h1>
    <p>Rendered from app/views/test/logtest.html.tpl.</p>

    (server-check (:session rc 'check)):  <%= server-check %><br>
    (cookies (rc-cookie rc)):  <%= cookies %><br>
    (sid  (:cookies-check rc "sid")):   <%= sid %><br>
    (prjid  (:cookies-check rc "prjid")):  <%= prjid %><br>
    (sid2  (:cookies-value rc "sid")):  <%= sid2 %><br>
    (prjid2  (:cookies-value rc "prjid")):  <%= prjid2 %><br>

    

    <form action="/test/loginaction" method="POST">
	<input type="submit" value="Login">
	<br><br>

	rc:
	<br><br>

	<%= rc %>
    </form>
  </body>
</html>
