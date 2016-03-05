<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
            <Scripts>
                <asp:ScriptReference Path="~/XMLHttpSyncExecutor.js" />
            </Scripts>
        </asp:ScriptManager>
        <div style="font-size: 2em; color: red;" id="server-time"></div>
        <input type="button" value="Get server time"
            onclick="$get('server-time').innerHTML = checkingSyncCalls(); return false;" />
    </form>
    <script type="text/javascript">

        function checkingSyncCalls() {
            var val = getServerTime();
            alert('After Post');
            return val;
        }

        function getServerTime() {
            // Instantiate a WebRequest.
            var wRequest = new Sys.Net.WebRequest();
            // Set the request URL.
            wRequest.set_url(PageMethods.get_path() + "/GetServerTime");
            // Set the request verb.
            wRequest.set_httpVerb('POST');

            wRequest.get_headers()['Content-Type'] = 'application/json; charset=utf-8';

            var params = { 'param1': 'sai' };
            var body = Sys.Serialization.JavaScriptSerializer.serialize(params);
            wRequest.set_body(body);

            var executor = new Sys.Net.XMLHttpSyncExecutor();
            wRequest.set_executor(executor);
            // Execute the request.
            wRequest.invoke();

            if (executor.get_responseAvailable()) {
                return executor.get_object();
            }

            return false;
        }
    </script>
</body>
</html>
