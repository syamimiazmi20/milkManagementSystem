// Mock user data
const userData = {
    firstName: "John",
    lastName: "Doe",
    dateOfBirth: "1990-01-01",
    email: "johndoe@example.com",
    phoneNumber: "1234567890",
    gender: "Male",
    address: "123 Main St",
    city: "New York",
    postcode: "10001",
    state: "NY",
    country: "USA"
};

// Function to display user's personal information
function displayPersonalInfo() {
    const container = document.getElementById('personalInfoContainer');
    container.innerHTML = `
        <h3>ACCOUNT INFORMATION</h3>
        <table align="center" cellpadding="5">
            <tr>
                <td>First Name</td>
                <td>${userData.firstName}</td>
            </tr>
            <tr>
                <td>Last Name</td>
                <td>${userData.lastName}</td>
            </tr>
            <tr>
                <td>Date Of Birth</td>
                <td>${userData.dateOfBirth}</td>
            </tr>
            <tr>
                <td>Email ID</td>
                <td>${userData.email}</td>
            </tr>
            <tr>
                <td>Phone Number</td>
                <td>${userData.phoneNumber}</td>
            </tr>
            <tr>
                <td>Gender</td>
                <td>${userData.gender}</td>
            </tr>
            <tr>
                <td>Address</td>
                <td>${userData.address}</td>
            </tr>
            <tr>
                <td>City</td>
                <td>${userData.city}</td>
            </tr>
            <tr>
                <td>Postcode</td>
                <td>${userData.postcode}</td>
            </tr>
            <tr>
                <td>State</td>
                <td>${userData.state}</td>
            </tr>
            <tr>
                <td>Country</td>
                <td>${userData.country}</td>
            </tr>
        </table>
        <div class="form-row-buttons">
            <button onclick="editPersonalInfo()">Edit</button>
            <button onclick="deleteAccount()">Delete</button>
        </div>
    `;
}

// Function to edit personal information
function editPersonalInfo() {
    const container = document.getElementById('personalInfoContainer');
    const fields = container.querySelectorAll('td:nth-child(2)');

    fields.forEach(field => {
        const currentValue = field.textContent;
        field.innerHTML = `<input type="text" value="${currentValue}">`;
    });

    const saveButton = document.createElement('button');
    saveButton.textContent = 'Save';
    saveButton.onclick = saveChanges;
    const cancelButton = document.createElement('button');
    cancelButton.textContent = 'Cancel';
    cancelButton.onclick = cancelEdit;

    const formRowButtons = container.querySelector('.form-row-buttons');
    formRowButtons.innerHTML = ''; // Clear existing buttons
    formRowButtons.appendChild(saveButton);
    formRowButtons.appendChild(cancelButton);
}

// Function to cancel edit and revert changes
function cancelEdit() {
    displayPersonalInfo(); // Re-display original personal information
}

// Function to save changes
function saveChanges() {
    const container = document.getElementById('personalInfoContainer');
    const inputs = container.querySelectorAll('input');
    inputs.forEach(input => {
        const newValue = input.value;
        const fieldName = input.parentNode.previousElementSibling.textContent.replace(' ', '').toLowerCase();
        userData[fieldName] = newValue;
    });
    displayPersonalInfo();
    alert("Personal information updated successfully!");
}

// Function to delete account
function deleteAccount() {
    const confirmDelete = confirm("Are you sure you want to delete your account?");
    if (confirmDelete) {
        // Perform account deletion
        // Redirect to login page
        window.location.href = "createAccount.html";
        alert("Account deleted successfully!");
    } else {
        alert("Account deletion cancelled.");
    }
}

// Function to update date and time
function updateDateTime() {
    const now = new Date();
    const dateTimeString = now.toLocaleString();
    document.getElementById('date-time').textContent = dateTimeString;
}

// Initially display user's personal information
displayPersonalInfo();

// Update date and time every second
setInterval(updateDateTime, 1000);
updateDateTime(); // Initial call

// Toggle the dropdown menu
document.querySelector('.dropdown-btn').addEventListener('click', function() {
    this.classList.toggle('active');
    var dropdownContent = this.nextElementSibling;
    if (dropdownContent.style.display === "block") {
        dropdownContent.style.display = "none";
    } else {
        dropdownContent.style.display = "block";
    }
});
