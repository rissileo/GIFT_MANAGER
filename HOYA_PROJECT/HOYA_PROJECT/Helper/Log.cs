using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;

namespace HOYA_PROJECT.Helper
{
    public class Log
    {
        public void GeraLog(string line)
        {
            string directory = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location) + "\\log";
            //string directory = HttpContext.Server.MapPath("~/log");

            string nomeArquivo = directory + "\\HOYA_PJCT_" + DateTime.Now.ToString("yyyyMMdd") + ".log";

            if (!Directory.Exists(directory))
            {
                System.IO.Directory.CreateDirectory(directory);
            }

            DeleteLogs(5, directory);

            StreamWriter log;

            if (!File.Exists(nomeArquivo))
            {
                log = new StreamWriter(nomeArquivo);
            }
            else
            {
                log = File.AppendText(nomeArquivo);
            }

            //Escreve no a data e hora do log
            log.WriteLine("[" + DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") + "] - " + line);

            // Fecha o log
            log.Close();
        }
        public void DeleteLogs(int period, string sPath)
        {
            string directoryPath = sPath;

            DirectoryInfo source = new DirectoryInfo(directoryPath);
            foreach (FileInfo fi in source.GetFiles())
            {
                if (fi.Extension.Equals(".log"))
                {
                    DateTime creationTime = fi.CreationTime;

                    if (creationTime < (DateTime.Now.AddDays(-period)))
                    {
                        fi.Delete();
                    }
                }
            }
        }
    }
}
