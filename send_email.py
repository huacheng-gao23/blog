import smtplib
import os
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

def fill_template(template, **kwargs):
    return template.format(**kwargs)

def send_email(sender_email, sender_password, recipient_email, subject, body):
    # Set up the MIME
    message = MIMEMultipart()
    message['From'] = sender_email
    message['To'] = recipient_email
    message['Subject'] = subject

    # Add body to email
    message.attach(MIMEText(body, 'plain'))

    # Create SMTP session
    with smtplib.SMTP('smtp.gmail.com', 587) as server:
        server.starttls()  # Enable security
        server.login(sender_email, sender_password)
        text = message.as_string()
        server.sendmail(sender_email, recipient_email, text)

# Email template
email_template = """Subject: Seeking Your Business Insight

Dear {owner_name},

I'm {your_name}, a software developer on a mission to solve enterprise challenges with technology.

Could you share 1-2 operational issues your business faces that you wish technology could solve?

Your insight would be invaluable.

Thank you for your time,
{your_name}
{your_contact_info}
"""

# Usage example
sender_email = "huacheng.gao@gmail.com"
sender_password = os.environ['APP_PASS']
recipient_email = "huacheng23@gmail.com"

# Fill in the template
email_body = fill_template(
    email_template,
    business_name="XYZ Corp",
    owner_name="John Doe",
    your_name="Huacheng Gao",
    your_contact_info="Email: huacheng.gao@gmail.com"
)

# Extract subject from the filled template
subject, _, body = email_body.partition('\n\n')
subject = subject.replace('Subject: ', '')

send_email(sender_email, sender_password, recipient_email, subject, body)
print("Email sent successfully!")