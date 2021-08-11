<!-- test#check view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<html><body>
    <h1>Page 2</h1>
    <h2>Server</h2>
    (server-check (:session rc 'check)) server side: <%= server-check  %><br>
    (cookies (rc-cookie rc)): <%= cookies  %><br>
    (sid  (:cookies-check rc "sid")): <%= sid  %><br>
    (prjid  (:cookies-check rc "prjid"): <%= prjid  %><br>
    <br><br>
    <h2>Client</h2>
    (sid2  (cookie-has-key? cookies "sid")):  <%= sid2  %><br>
    (prjid2  (cookie-has-key? cookies "prjid")): <%= prjid2  %><br>
    (sid3  (:cookies-value rc "sid")): <%= sid3  %><br>
    (prjid3  (:cookies-value rc "prjid")): <%= prjid3  %><br>

    
    rc:
    <br><br>

    <%= rc %>
</body></html>
