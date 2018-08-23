<%--
  Footer

  author: REX
  version: 1.0
  since: 2018.08.07
--%>
<div class="footer">Copyright © 2018 PaaS-TA. All rights reserved</div>

<script type="text/javascript">
    // ON LOAD
    $(document.body).ready(function () {
        procSetMenuCursor();

        var clipboard = new ClipboardJS('.bar');
        clipboard.on('success', function(e) {
            alert("복사되었습니다.");
            console.log(e);
        });
        clipboard.on('error', function(e) {
            console.log(e);
        });
    });
</script>
