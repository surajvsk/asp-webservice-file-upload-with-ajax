<%@ Page Title="Home Page" Language="C#"  AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebServiceFileUploadEx._Default" %>


<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
  </head>
  <body>
   <table>
        <tr>
            <td>First Name:</td>
            <td><input type="text" id="firstName" /></td>
        </tr>
        <tr>
            <td>File:</td>
            <td><input type="file" id="file" /></td>
        </tr>
        <tr>
            <td></td>
            <td><input type="button" id="btnUpload" value="Upload" /></td>
        </tr>
        <tr>
            <td colspan="2"><progress id="fileProgress" style="display: none"></progress></td>
        </tr>
    </table>
    <hr/>
    <span id="lblMessage" style="color: Green"></span>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        $("body").on("click", "#btnUpload", function () {
            var formData = new FormData();
            formData.append("firstName", $("#firstName").val());
            formData.append("file", $("#file")[0].files[0]);
            $.ajax({
                url: 'WebService1.asmx/FileUpload',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (responsejson) {
                    console.log('fileName:::::::::', responsejson)
                    $("#fileProgress").hide();
                    $("#lblMessage").html("<b>" + responsejson + "</b> has been uploaded.");
                },
                xhr: function () {
                    var fileXhr = $.ajaxSettings.xhr();
                    if (fileXhr.upload) {
                        $("progress").show();
                        fileXhr.upload.addEventListener("progress", function (e) {
                            if (e.lengthComputable) {
                                $("#fileProgress").attr({
                                    value: e.loaded,
                                    max: e.total
                                });
                            }
                        }, false);
                    }
                    return fileXhr;
                }
            });
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
  </body>
</html>