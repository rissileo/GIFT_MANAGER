using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;

namespace HOYA_PROJECT.Helper
{
    public class SendMail
    {
        ReadXML xml = new ReadXML();

        public string mailFrom { get; set; }
        public string user { get; set; }
        public string pass { get; set; }
        public string smtpServer { get; set; }
        public string smtpPort { get; set; }

        public bool Enviar(string emailTo,
                           string subject,
                           string message)
        {
            try
            {
                this.mailFrom = xml.Read("settings.xml", "settings/mail", "mailFrom");
                this.user = xml.Read("settings.xml", "settings/mail", "user");
                this.pass = xml.Read("settings.xml", "settings/mail", "pass");
                this.smtpServer = xml.Read("settings.xml", "settings/mail", "smtpServer");
                this.smtpPort = xml.Read("settings.xml", "settings/mail", "smtpPort");

                using (MailMessage mailMessage = new MailMessage())
                {
                    mailMessage.From = new MailAddress(this.mailFrom);
                    mailMessage.Subject = subject;
                    mailMessage.IsBodyHtml = true;
                    mailMessage.Body = message;
                    mailMessage.To.Add(new MailAddress(emailTo));
                    SmtpClient smtp = new SmtpClient(this.smtpServer, int.Parse(this.smtpPort));
                    smtp.EnableSsl = true;
                    smtp.UseDefaultCredentials = false;
                    System.Net.NetworkCredential NetworkCred = new System.Net.NetworkCredential(this.user, this.pass);
                    smtp.Credentials = NetworkCred;
                    smtp.Timeout = 10000;
                    smtp.Send(mailMessage);
                }

                return true;

                //SmtpClient client = new SmtpClient(smtpServer);
                //client.EnableSsl = true;
                //client.Port = int.Parse(smtpPort);
                //client.DeliveryMethod = SmtpDeliveryMethod.Network; // modo de envio
                //client.UseDefaultCredentials = false; // vamos utilizar credencias especificas
                //client.Credentials = new NetworkCredential(user, pass);

                //MailMessage mailMessage = new MailMessage();
                //mailMessage.From = new MailAddress(this.mailFrom);
                //mailMessage.To.Add(emailTo);
                //mailMessage.IsBodyHtml = true;
                //mailMessage.Body = message;
                //mailMessage.Priority = MailPriority.High;
                //mailMessage.Subject = subject;
                //client.Send(mailMessage);

                //return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}
