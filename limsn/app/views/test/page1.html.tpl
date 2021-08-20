<!-- test#check view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<html><body>
    <h1>Page 1</h1>

    (server-check (:session rc 'check)) server side: <%= server-check  %><br>
    (cookies (rc-cookie rc)): <%= cookies  %><br>
    (sid  (:cookies-check rc "sid")): <%= sid  %><br>
    (prjid  (:cookies-check rc "prjid"): <%= prjid  %><br>
    (sid2  (:cookies-value rc "sid")):  <%= sid2 %><br>
    (prjid2  (:cookies-value rc "prjid")):  <%= prjid2 %><br>
    current-myhost:   <%= cmyhost %><br>
    wauth:   <%= wauth %><br>
    
    <br><br>
    <form action="/test/page1action" method="POST">
	<input type="submit" value="Send Request">
	<br><br>

	rc:
	<br><br>

	<%= rc %>
</form></body>    </html>
