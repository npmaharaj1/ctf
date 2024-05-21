<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Login</title>
        <script src="login.js" defer></script>
    </head>
    <body>
        <h1 style="text-align: center;">Administrator Login</h1>
        <div style="text-align: center; margin-top: 20%;">
            <input id="usernameField" type="text" placeholder="User">
            <br>
            <input id="passwordField" type="password" placeholder="Password" style="margin-top: 1%;">
            <br>
            <input type="button" value="Login" style="margin-top: 1%;" onclick="login()">
            <br>
            <p id="incorrectPassword" style="color: red;">Incorrect Password, Try Again!</p>
        </div>
    </body>
</html>