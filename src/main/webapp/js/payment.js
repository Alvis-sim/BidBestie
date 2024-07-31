document.addEventListener("DOMContentLoaded", function() {
    var stripe = Stripe('pk_test_51PYQCORpr2L9wI5un6zMRFL5IxvSp5n58ACRSLKNmKq2K0wF8mjQYadL3Ok5oUCxXnAvYPOOOROPSzbREllmzhKn001uCrkuQp'); // Replace with your actual publishable key
    var elements = stripe.elements();

    var style = {
        base: {
            color: '#32325d',
            fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
            fontSmoothing: 'antialiased',
            fontSize: '16px',
            '::placeholder': {
                color: '#aab7c4'
            }
        },
        invalid: {
            color: '#fa755a',
            iconColor: '#fa755a'
        }
    };

    var card = elements.create('card', {style: style});
    card.mount('#card-element');

    card.on('change', function(event) {
        var displayError = document.getElementById('card-errors');
        if (event.error) {
            displayError.textContent = event.error.message;
            console.error("Card error: ", event.error.message);
        } else {
            displayError.textContent = '';
        }
    });

    var form = document.getElementById('payment-form');
    form.addEventListener('submit', function(event) {
        event.preventDefault();
        console.log("Form submitted, creating token...");

        stripe.createToken(card).then(function(result) {
            if (result.error) {
                var errorElement = document.getElementById('card-errors');
                errorElement.textContent = result.error.message;
                console.error("Token creation error: ", result.error.message);
            } else {
                console.log("Token created successfully: ", result.token);
                stripeTokenHandler(result.token);
            }
        });
    });

    function stripeTokenHandler(token) {
        var form = document.getElementById('payment-form');
        console.log("Form element: ", form);
        console.log("Form methods: ", Object.keys(form));

        if (typeof form.submit === 'function') {
            var hiddenInput = document.createElement('input');
            hiddenInput.setAttribute('type', 'hidden');
            hiddenInput.setAttribute('name', 'stripeToken');
            hiddenInput.setAttribute('value', token.id);
            form.appendChild(hiddenInput);

            console.log("Token added to form, submitting form...");
            form.submit();
        } else {
            console.error("Form submit is not a function. Element:", form);
            console.dir(form);
        }
    }
});
