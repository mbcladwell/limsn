<!-- project#add view template of lnserver
          Please add your license header here.
          This file is generated automatically by GNU Artanis. -->
  
<@include header.tpl %>

  <div class="container">
  <h1>Registration</h1><br>

  This copy of LIMS*Nucleus is registered&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><br>
<form>
  <div class="input-group">
    <div class="form-group w-100">
      <textarea  id="copy-input" name="copy-input" aria-label="With textarea" rows="8" class="form-control"><%= alltext %></textarea>
    </div>
    <span class="input-group-btn">
      <button class="btn btn-primary" type="button" id="copy-button"
              data-toggle="tooltip" data-placement="button"   data-clipboard-target="#copy-input"

              title="Copy to Clipboard">
        Copy
      </button>
    </span>
  </div>
</form>

<script>
new ClipboardJS('.btn');
 </script>
<@include footer.tpl %>

