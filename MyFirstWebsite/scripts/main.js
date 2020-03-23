window.onload = () => {

    const submitButton = document.getElementById('submit-button');
    const emailField = document.getElementById('email');

    submitButton.addEventListener('click' , () => {
    
        const emailText = emailField.value;
        console.log('The button was clicked', emailText);

        if(emailText.length === 0) {
            alert('Please enter a valid email');
        } else {
            alert('We will contact you shortly');
        }
    })

    console.log('Hello this document has loaded');
}