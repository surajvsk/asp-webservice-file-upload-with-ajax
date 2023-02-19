using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Services;

namespace WebServiceFileUploadEx
{
    /// <summary>
    /// Summary description for WebService1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
     [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {

        [WebMethod]
        public void FileUpload()
        {
            //Create Directory If not Exists.
            string path = HttpContext.Current.Server.MapPath("~/Content/Uploads/");
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }

            //Fetch the File. 
            HttpPostedFile postedFile = HttpContext.Current.Request.Files[0];

            //Fetch the File Name. Or you can use UUID FOR UNIQUE NAME
            Guid myuuid = Guid.NewGuid();
            string uniquefileName = myuuid.ToString();
            string fileName = uniquefileName + Path.GetExtension(postedFile.FileName);

            //Fetch Text Box Value using Ajax form Data
            string firstName = HttpContext.Current.Request.Form["firstName"];

            //Save the File.
            postedFile.SaveAs(path + fileName);

            Dictionary<string, string> map = new Dictionary<string, string>();
            map.Add("firstName", firstName);
            map.Add("filePath", "~/Content/Uploads/" + fileName);

            string responsejson = JsonConvert.SerializeObject(map);

            //Send OK Response to Client.
            HttpContext.Current.Response.StatusCode = (int)HttpStatusCode.OK;
            // HttpContext.Current.Response.Write(fileName);// Send your response
            HttpContext.Current.Response.Write(responsejson);
            HttpContext.Current.Response.Flush();

        }
    }
}
