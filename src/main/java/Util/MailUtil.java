package Util;

import java.util.Properties;

import jakarta.mail.*;
import jakarta.mail.internet.*;

public class MailUtil {
    
    public static void sendMail(String to, String subject, String html) throws MessagingException {
    	final String from = "mtmblg246@gmail.com"; // Gmail của bạn
        final String appPassword = "qoua rpwr uqtk mzzo"; // App Password 16 ký tự

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // 🧩 Tạo phiên đăng nhập
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, appPassword);
            }
        });

        MimeMessage message = new MimeMessage(session);
        // KHÔNG gắn "personal name" -> không còn UnsupportedEncodingException
        message.setFrom(new InternetAddress(from));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject, "UTF-8");
        message.setContent(html, "text/html; charset=UTF-8");

        Transport.send(message);
    }
}
