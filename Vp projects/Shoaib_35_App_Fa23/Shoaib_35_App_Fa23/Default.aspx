<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Shoaib_35_App_Fa23._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        h1 {
            text-align: center;
            color: blanchedalmond;
        }

        table, th, td {
            width: 50%;
            border: 2px solid #0e467e;
            margin-left: auto;
            margin-right: auto;
            text-align: center;
            color: palevioletred;
        }

        .txtbtnStyle {
            border: 2px solid #400817;
            font-family: sans-serif;
            font-size: large;
            font-weight: bold;
            color: aliceblue;
            width: Auto;
            margin: 2px 1px;
        }
    </style>

    <div>
        <div>
            <h1><u>Employee Managment System</u></h1>
            <table>
                <tr>
                    <th>Field Name</th>
                    <th>Information</th>
                </tr>
                <tr>
                    <td>Emp ID</td>
                    <td>
                        <asp:TextBox ID="txtMaterialID" CssClass="txtbtnStyle" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Employee Name</td>
                    <td>
                        <asp:TextBox ID="txtMaterialName" CssClass="txtbtnStyle" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Level</td>
                    <td>
                        <asp:TextBox ID="txtQuantity" CssClass="txtbtnStyle" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Salary</td>
                    <td>
                        <asp:TextBox ID="txtPrice" CssClass="txtbtnStyle" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Description</td>
                    <td>
                        <asp:TextBox ID="txtDescription" CssClass="txtbtnStyle" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td> ID</td>
                    <td>
                        <asp:TextBox ID="txtElementID" CssClass="txtbtnStyle" runat="server"></asp:TextBox>
                    </td>
                </tr>
                    <tr>
                    <td>Name</td>
                    <td>
                        <asp:TextBox ID="txtElementName" CssClass="txtbtnStyle" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Element Tag</td>
                    <td>
                        <asp:TextBox ID="txtElementtag" CssClass="txtbtnStyle" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <span style="color:red">
                            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                        </span>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <asp:Button ID="btnInsert" CssClass="txtbtnStyle" runat="server" Text="Insert" OnClick="btnInsert_Click" />
                        <asp:Button ID="btnSearch" CssClass="txtbtnStyle" runat="server" Text="Search" OnClick="btnSearch_Click" />
                        <asp:Button ID="btnUpdate" CssClass="txtbtnStyle" runat="server" Text="Update" OnClick="btnUpdate_Click" />
                        <asp:Button ID="btnDelete" CssClass="txtbtnStyle" runat="server" Text="Delete" OnClick="btnDelete_Click" />
                    </td>
                </tr>
            </table>
            <br />
            <asp:GridView ID="GridView1" runat="server"></asp:GridView>
            <div><asp:GridView ID="GridView2" runat="server"></asp:GridView></div>
        </div>
    </div>
</asp:Content>
