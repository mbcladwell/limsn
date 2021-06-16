<!-- test#check view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->

<html><body>
    <h1>Page 1</h1>

    server: <%= server-check  %><br>
    client: <%= sid  %><br>
    prjid: <%= prjid-check  %><br>
    numplates <%= nplates %>
<form action="/test/page1action" method="POST">
<input type="submit" value="Send Request">
</form></body>    </html>
