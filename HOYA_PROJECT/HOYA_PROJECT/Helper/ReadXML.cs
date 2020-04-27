using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using System.Xml;

namespace HOYA_PROJECT.Helper
{
    public class ReadXML
    {
        public string PegaCampoPorNo(string Caminho, string Elemento, string Node)
        {

            XmlDocument doc = new XmlDocument();
            doc.Load(Caminho);
            XmlNode node = doc.SelectSingleNode(Elemento + "/" + Node);
            return node.InnerText;

        }

        public string Read(string strFileName, string strNode, string strSingleNode)
        {
            string XMLField = "";

            try
            {
                //FileName = Nome do arquivo que será lido 
                //Node = Os pais da tag onde contem a string desejada (Se tiver mais de uma separar por "/")
                //SigleNode = A tag onde contem a string desejada

                XmlDocument doc = new XmlDocument();
                doc.Load(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location) + "/" + strFileName);
                XmlNodeList nodeListSocket = doc.SelectNodes(strNode);

                //Recupera a Intevalo da Requisicao do arquivo de Configurações
                foreach (XmlNode node in nodeListSocket)
                    XMLField = node.SelectSingleNode(strSingleNode).InnerText;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }

            return XMLField;

        }

        public ArrayList ReadList(string strFileName, string strNode, string strSingleNode)
        {
            ArrayList myData = new ArrayList();


            XmlDocument doc = new XmlDocument();
            doc.Load(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location) + "/" + strFileName);
            XmlNodeList nodeList = doc.SelectNodes(strNode);

            foreach (XmlNode node in nodeList)
                if (!myData.Contains(node.SelectSingleNode(strSingleNode).InnerText))
                    myData.Add(node.SelectSingleNode(strSingleNode).InnerText);

            return myData;
        }

        public string ReadExactData(string strFileName, string strNode, string strSingleNode, string strAplicacao)
        {
            string XMLField = "";

            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location) + "/" + strFileName);
                XmlNodeList nodeList = doc.SelectNodes(strNode);

                foreach (XmlNode node in nodeList)
                    if (node.SelectSingleNode("Nome").InnerText == strAplicacao)
                        XMLField = node.SelectSingleNode(strSingleNode).InnerText;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
            return XMLField;
        }

        public void EscreverXML(string strFileName, string strNode, string strSingleNode, string dado)
        {
            try
            {
                string fileLoc = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location) + "/" + strFileName;
                XmlDocument doc = new XmlDocument();
                doc.Load(fileLoc);
                XmlNode node = doc.SelectSingleNode("//" + strNode + "//" + strSingleNode);
                if (node != null)
                {
                    node.InnerText = dado;
                }
                else
                {
                    XmlNode root = doc.DocumentElement;
                    XmlElement elem;
                    elem = doc.CreateElement(strSingleNode);
                    elem.InnerText = dado;
                    root.AppendChild(elem);
                }
                doc.Save(fileLoc);
                doc = null;
            }
            catch (Exception)
            {
                /*
                 * Possible Exceptions:
                 *  System.ArgumentException
                 *  System.ArgumentNullException
                 *  System.InvalidOperationException
                 *  System.IO.DirectoryNotFoundException
                 *  System.IO.FileNotFoundException
                 *  System.IO.IOException
                 *  System.IO.PathTooLongException
                 *  System.NotSupportedException
                 *  System.Security.SecurityException
                 *  System.UnauthorizedAccessException
                 *  System.UriFormatException
                 *  System.Xml.XmlException
                 *  System.Xml.XPath.XPathException
                */
            }
        }
    }
}
