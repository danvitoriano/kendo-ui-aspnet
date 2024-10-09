<%@ Page Language="C#"  %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head runat="server">
    <title>Telerik ASP.NET Example</title>
    <style type="text/css">
        .rgRow, .rgAltRow {
            height: 40px;
        }
    </style>
    <script type="text/javascript">
        //<![CDATA[
        function ParameterMap(sender, args) {
            //If you want to send a parameter to the select call you can modify the if 
            //statement to check whether the request type is 'read':
            //if (args.get_type() == "read" && args.get_data()) {
            if (args.get_type() != "read" && args.get_data()) {
                args.set_parameterFormat({ customersJSON: kendo.stringify(args.get_data().models) });
            }
        }

        function Parse(sender, args) {
            var response = args.get_response().d;
            if (response) {
                args.set_parsedData(response.Data);
            }
        }

        function UserAction(sender, args) {
            if (sender.get_batchEditingManager().hasChanges(sender.get_masterTableView()) &&
                !confirm("Any changes will be cleared. Are you sure you want to perform this action?")) {
                args.set_cancel(true);
            }
        }
        //]]>
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" ShowChooser="true" />
    <telerik:RadFormDecorator RenderMode="Lightweight" runat="server" DecorationZoneID="grid" DecoratedControls="All" EnableRoundedCorners="false" />
    <div class="demo-container no-bg">
        <h3>RadGrid bound to RadClientDataSource</h3>
        <div id="grid">
            <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" ClientDataSourceID="RadClientDataSource1" AllowPaging="true" AllowSorting="true" AllowFilteringByColumn="true">
                <MasterTableView ClientDataKeyNames="CustomerID" EditMode="Batch" CommandItemDisplay="Top" BatchEditingSettings-HighlightDeletedRows="true">
                    <Columns>
                        <telerik:GridBoundColumn DataField="CustomerID" HeaderText="Customer ID" ReadOnly="true">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="CompanyName" HeaderText="Company Name" ColumnEditorID="GridTextBoxEditor">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ContactName" HeaderText="Contact Name" ColumnEditorID="GridTextBoxEditor">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="ContactTitle" HeaderText="Contact Title" ColumnEditorID="GridTextBoxEditor">
                        </telerik:GridBoundColumn>
                        <telerik:GridClientDeleteColumn HeaderText="Delete">
                            <HeaderStyle Width="70px" />
                        </telerik:GridClientDeleteColumn>
                    </Columns>
                </MasterTableView>
                <ClientSettings>
                    <ClientEvents OnUserAction="UserAction" />
                </ClientSettings>
            </telerik:RadGrid>
        </div>
        <telerik:GridTextBoxColumnEditor ID="GridTextBoxEditor" runat="server" TextBoxStyle-Width="230px"></telerik:GridTextBoxColumnEditor>
        <telerik:RadClientDataSource ID="RadClientDataSource1" runat="server" AllowBatchOperations="true">
            <ClientEvents OnCustomParameter="ParameterMap" OnDataParse="Parse" />
            <DataSource>
                <WebServiceDataSourceSettings BaseUrl="EditingWcfService.svc/">
                    <Select Url="GetCustomers" DataType="JSON" />
                    <Update Url="UpdateCustomers" DataType="JSON" />
                    <Insert Url="InsertCustomers" DataType="JSON" />
                    <Delete Url="DeleteCustomers" DataType="JSON" />
                </WebServiceDataSourceSettings>
            </DataSource>
            <Schema>
                <Model ID="CustomerID">
                    <telerik:ClientDataSourceModelField FieldName="CustomerID" DataType="String" />
                    <telerik:ClientDataSourceModelField FieldName="CompanyName" DataType="String" />
                    <telerik:ClientDataSourceModelField FieldName="ContactName" DataType="String" />
                    <telerik:ClientDataSourceModelField FieldName="ContactTitle" DataType="String" />
                </Model>
            </Schema>
        </telerik:RadClientDataSource>
    </div>
    </form>
</body>
</html>