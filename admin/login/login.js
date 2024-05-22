let incorrectPassword = document.getElementById("incorrectPassword");
incorrectPassword.style.display = "none";

if (localStorage.getItem("sessionToken") == "a1fa59e79bba1a38bb0684d3298c9ddd") {
    window.location.replace("../../admin");
} 

function login() {
    let username = document.getElementById("usernameField").value;
    let password = document.getElementById("passwordField").value;

    if (username == "admin" && password == "bbb2c5e63d2ef893106fdd0d797aa97a") {
        localStorage.setItem("sessionToken", "a1fa59e79bba1a38bb0684d3298c9ddd");
        window.location.replace("../../admin");
    } else {
        incorrectPassword.style.display = "block";
    }
}