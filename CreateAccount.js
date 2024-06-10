function showEmployeeFields() { 
    document.getElementById('employee-fields').style.display = 'block'; 
    document.getElementById('customer-fields').style.display = 'none'; 
} 
 
function showCustomerFields() { 
    document.getElementById('employee-fields').style.display = 'none'; 
    document.getElementById('customer-fields').style.display = 'block'; 
} 
 
function showEmployeeSignup() { 
    document.getElementById('signup-employee-fields').style.display = 'block'; 
    document.getElementById('signup-customer-fields').style.display = 'none'; 
} 
 
function showCustomerSignup() { 
    document.getElementById('signup-employee-fields').style.display = 'none'; 
    document.getElementById('signup-customer-fields').style.display = 'block'; 
} 
 
function showSignup() { 
    document.querySelector('.login').style.display = 'none'; 
    document.querySelector('.registration').style.display = 'block'; 
} 
 
function showLogin() { 
    document.querySelector('.login').style.display = 'block'; 
    document.querySelector('.registration').style.display = 'none'; 
} 
 
function redirectToLoginPage() { 
  window.location.href = 'createAccount.html'; // Redirect to login page 
}