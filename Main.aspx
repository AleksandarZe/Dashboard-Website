<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Main.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Dashboard Website</title>
    <link href="StyleSheet.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.12.4.js"></script>
    <script src="Scripts/jquery-ui-1.12.1.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:DropDownList ID="ThemeList" runat="server" AutoPostBack="true" >
            <asp:ListItem>DeepSkyBlue</asp:ListItem>
            <asp:ListItem>Bisque</asp:ListItem>
        </asp:DropDownList>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div id="dvDiv" class="Element" style="position:absolute">
            <asp:CheckBox 
                ID="dvCheckBox"
                autopostback="true"
                checked="false"
                runat="server" OnCheckedChanged="dvCheckBox_CheckedChanged" /> Show Details
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <asp:Panel ID="dvPanel" visible="false" runat="server">
                          <asp:DetailsView 
                                    ID="dvEmployees" 
                                    runat="server" AllowPaging="True" AutoGenerateRows="False" DataKeyNames="EmpID" DataSourceID="dataSorceEmployees" OnItemDeleted="dvEmployees_ItemDeleted" >
                                    <Fields>
                                        <asp:BoundField DataField="EmpID" HeaderText="EmpID" InsertVisible="False" ReadOnly="True" SortExpression="EmpID" />
                                        <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                                        <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True" />
                                    </Fields>

                          </asp:DetailsView >
                        <div id="SummaryDiv">
                          <asp:GridView ID="gvSummary" runat="server" AutoGenerateColumns="False" DataSourceID="sqlSummarySales">
                              <Columns>
                                  <asp:TemplateField HeaderText="Summary" SortExpression="Column1">
                                      <EditItemTemplate>
                                          <asp:Label ID="Label1" runat="server" Text='<%# Eval("Column1") %>'></asp:Label>
                                      </EditItemTemplate>
                                      <ItemTemplate>
                                          <asp:Label ID="Label1" runat="server" Text='<%# Bind("Column1", "{0:C}") %>'></asp:Label>
                                      </ItemTemplate>
                                  </asp:TemplateField>
                                  <asp:BoundField DataField="EmpID" HeaderText="EmpID" SortExpression="EmpID" />
                              </Columns>
                          </asp:GridView>
                        </div>
                          <asp:SqlDataSource ID="sqlSummarySales" runat="server" ConnectionString="<%$ ConnectionStrings:mydbaseConnectionString %>" SelectCommand="select sum(amount), EmpID from SalesTable where EmpID=@EmpID
group by EmpID">
                              <SelectParameters>
                                  <asp:ControlParameter ControlID="dvEmployees" Name="EmpID" PropertyName="SelectedValue" />
                              </SelectParameters>
                          </asp:SqlDataSource>
                          <br />
                        <div id="SalesDiv">
                        <asp:GridView ID="gvSales" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SalesTableDataSource" OnRowDeleted="gvSales_RowDeleted" OnRowEditing="gvSales_RowEditing" OnRowUpdated="gvSales_RowUpdated">
                            <Columns>
                                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="ID" />
                                <asp:BoundField DataField="EmpID" HeaderText="EmpID" SortExpression="EmpID" />
                                <asp:BoundField DataField="MonthOnly" HeaderText="MonthOnly" SortExpression="MonthOnly" />
                                <asp:TemplateField HeaderText="DateSold" SortExpression="DateSold">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("DateSold") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("DateSold", "{0:d}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Amount") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("Amount", "{0:C}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                          </asp:GridView>
                        </div>
                     </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
            

            <asp:SqlDataSource ID="dataSorceEmployees" runat="server" ConnectionString="<%$ ConnectionStrings:mydbaseConnectionString %>" DeleteCommand="DELETE FROM [EmployeesTable] WHERE [EmpID] = @EmpID" InsertCommand="INSERT INTO [EmployeesTable] ([FirstName], [LastName]) VALUES (@FirstName, @LastName)" SelectCommand="SELECT [EmpID], [FirstName], [LastName] FROM [EmployeesTable]" UpdateCommand="UPDATE [EmployeesTable] SET [FirstName] = @FirstName, [LastName] = @LastName WHERE [EmpID] = @EmpID">
                <DeleteParameters>
                    <asp:Parameter Name="EmpID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="EmpID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SalesTableDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:mydbaseConnectionString %>" DeleteCommand="DELETE FROM [SalesTable] WHERE [ID] = @ID" InsertCommand="INSERT INTO [SalesTable] ([EmpID], [MonthOnly], [DateSold], [Amount]) VALUES (@EmpID, @MonthOnly, @DateSold, @Amount)" SelectCommand="SELECT [ID], [EmpID], [MonthOnly], [DateSold], [Amount] FROM [SalesTable] WHERE ([EmpID] = @EmpID)" UpdateCommand="UPDATE [SalesTable] SET [EmpID] = @EmpID, [MonthOnly] = @MonthOnly, [DateSold] = @DateSold, [Amount] = @Amount WHERE [ID] = @ID">
                <DeleteParameters>
                    <asp:Parameter Name="ID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="EmpID" Type="Int32" />
                    <asp:Parameter Name="MonthOnly" Type="String" />
                    <asp:Parameter DbType="Date" Name="DateSold" />
                    <asp:Parameter Name="Amount" Type="Decimal" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="dvEmployees" Name="EmpID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="EmpID" Type="Int32" />
                    <asp:Parameter Name="MonthOnly" Type="String" />
                    <asp:Parameter DbType="Date" Name="DateSold" />
                    <asp:Parameter Name="Amount" Type="Decimal" />
                    <asp:Parameter Name="ID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
        <div id="divSticky" class="Element" style="position:absolute">
            <textarea id="txtSticky" cols="20" rows="10" style="background-color:yellow"></textarea>
        </div>
        <br />
       <asp:Menu id="PrintMenu" runat="server" style="font-family:Arial" >
           <Items>
               <asp:MenuItem Text="Print"> 
                    <asp:MenuItem Text="Summary Grid"></asp:MenuItem>
                     <asp:MenuItem Text="Sales Record"></asp:MenuItem>
               </asp:MenuItem>
               
           </Items>
       </asp:Menu>

    </form>
    <script>
        $("#dvDiv").draggable()
        $("#divSticky").draggable()
        $(window).on('beforeunload', function () {
            var pos = $("#dvDiv").position()
            var color = $("#ThemeList Option:Selected").text()
            var stickyPos=$("#divSticky").position()
            localStorage.setItem('dvDiv', JSON.stringify(pos))
            localStorage.setItem('dvDivColor', color)
            localStorage.setItem('StickyPosition', JSON.stringify(stickyPos))
            var text = $("#txtSticky").val()
            localStorage.setItem('StickyText',text)
        });
        var topLeft = JSON.parse(localStorage.getItem('dvDiv'))
        var backColor = localStorage.getItem('dvDivColor')
        var stickyPos = JSON.parse(localStorage.getItem('StickyPosition'))
        var text = localStorage.getItem('StickyText')

        $("#divSticky").css(stickyPos)
        $("#ThemeList").val(backColor)
        $("#dvDiv").css(topLeft)
        $("#dvDiv").css("background-color", backColor)
        $("#txtSticky").val(text)
        $("#divSticky").css("background-color", backColor)

        $("li>a").click(function () {

            if ($(this).text() == "Summary Grid")
            {
                var contents = document.getElementById("SummaryDiv").innerHTML;
                var printDocument = window.open("", "", "height=500, width=500");
                printDocument.document.write(contents);
                printDocument.print();
                printDocument.close();
            }

            if ($(this).text() == "Sales Record")
            {
                var contents = document.getElementById("SalesDiv").innerHTML;
                var printDocument = window.open("", "", "height=500,width=500");
                printDocument.document.write(contents);
                printDocument.print();
                printDocument.close();
            }

        });

        
    </script>
</body>
</html>
