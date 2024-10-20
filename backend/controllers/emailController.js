// emailController.js
const sgMail = require('@sendgrid/mail');
sgMail.setApiKey(process.env.SENDGRID_API_KEY); 

// Send confirmation email when booking is created
const sendBookingConfirmationEmail = async (userEmail, bookingDetails) => {
  const msg = {
    to: userEmail, 
    from: 'parkfinderr@gmail.com', 
    subject: 'Booking Confirmation - Park Finder',
    text: `Your booking for ${bookingDetails.landName} has been confirmed.`,
    html: `<strong>Your booking for ${bookingDetails.landName} on ${bookingDetails.startTime} has been confirmed. Please Pay ${bookingDetails.fee}</strong>`,
  };

  try {
    await sgMail.send(msg);
    console.log('Confirmation email sent to', userEmail);
  } catch (error) {
    console.error('Error sending confirmation email:', error);
  }
};

module.exports = { sendBookingConfirmationEmail };
