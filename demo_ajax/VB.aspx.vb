Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Web.Services
Imports System.Web.Script.Services

Partial Class VB
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Me.IsPostBack Then
            Dim constr As String = ConfigurationManager.ConnectionStrings("constr").ConnectionString
            Using con As New SqlConnection(constr)
                Using cmd As New SqlCommand("SELECT * FROM Users")
                    Using sda As New SqlDataAdapter()
                        Dim dt As New DataTable()
                        cmd.CommandType = CommandType.Text
                        cmd.Connection = con
                        sda.SelectCommand = cmd
                        sda.Fill(dt)
                        gvUsers.DataSource = dt
                        gvUsers.DataBind()
                    End Using
                End Using
            End Using
        End If
    End Sub

    <WebMethod()> _
    <ScriptMethod()> _
    Public Shared Sub SaveUser(user As User)
        Dim constr As String = ConfigurationManager.ConnectionStrings("constr").ConnectionString
        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("INSERT INTO Users VALUES(@Username, @Password)")
                cmd.CommandType = CommandType.Text
                cmd.Parameters.AddWithValue("@Username", user.Username)
                cmd.Parameters.AddWithValue("@Password", user.Password)
                cmd.Connection = con
                con.Open()
                cmd.ExecuteNonQuery()
                con.Close()
            End Using
        End Using
    End Sub
End Class
Public Class User
    Public Property Username() As String
        Get
            Return _Username
        End Get
        Set(value As String)
            _Username = value
        End Set
    End Property
    Private _Username As String
    Public Property Password() As String
        Get
            Return _Password
        End Get
        Set(value As String)
            _Password = Value
        End Set
    End Property
    Private _Password As String
End Class

