# ctf
Beginner level Capture the Flag (user and root flag included)

<h2>On your VM that will be running the CTF, run the following commands:</h2>

```
wget https://raw.githubusercontent.com/npmaharaj1/ctf/main/ctf_build.sh
chmod u+x ctf_build.sh
sudo ./ctf_build.sh
```

<h2>On your host machine or VM (whatever you are going to be hacking the CTF with), run the following commands:</h2>

```
wget https://raw.githubusercontent.com/npmaharaj1/ctf/main/attack_build.sh
chmod u+x attack_build.sh
sudo ./attack_build.sh
```
<h2>Walkthrough</h2>
Note that the <i>{ip address}</i> signifies the ip address of the server, please don't include the {}. <br>
<br>
To startup off this CTF, we are given an ip address. In cybersecurity, IP Addresses can lead to a veriety of exploits such as open ports or unmaintained programs. To start off we can do some basic enumeration to check for open ports. This will use nmap (network mapper) to scan the top 1000 ports of the ip address and print out all the information into the file scan.initial.

```
nmap -A {ip address} -oN scan.initial
```

When looking at the results, we can see that there are open ports, namely:
- 22: for OpenSSH
- 80: for an Apache2 web server (it also seems to be a test page based on the child results)

Let's open our browser and navigate to that ip address to have a look
```
http://{ip address}:80
```

Like the results said, it seems to be a test page<br>
Apache test pages aren't normally hackable since it's just a webpage, but what if there are other directories in the webserver. We can find out using a tool called FFUF. The following command will tell fuff to look at the website and use a wordlist to look at each instance. Let's run: 
```
ffuf -u http://{ip address}:80/FUZZ -w common.txt
```

Looking at the results there seems to be an admin page and the test page we just saw: `index.html`. Let's have a look at the admin page
```
http://{ip address}:80/admin
``` 

Of course, modern admin pages have a login form and to break it we need to know the password. However, what if we use inspect element to look at the underlying code. There is a possability that we fill find client side authentication.
```
ctrl + shift + I and head over to the debugger tab
```

If we expand admin/login, there's a login.js file! Let's see what's in there.

We were correct, there is client side authentication because of the:
```
    if (username == "admin" && password == "bbb2c5e63d2ef893106fdd0d797aa97a") {
        localStorage.setItem("sessionToken", "a1fa59e79bba1a38bb0684d3298c9ddd");
        window.location.replace("../../admin");
    } else {
        incorrectPassword.style.display = "block";
    }
```

Now, putting in the password is reasonable but it is more fun to put our own session token. To do this we need to open the Storage tab in the inspect element menu and go to the local storage tab. We then press the menu that has an ip address. On chromium and firefox based browsers, there should be a plus button on the top right of the menu. If we tap that we can enter our own local storage values.

Let's enter in the data so it looks like this
```
________________________________________________________
|     Key      |                 Value                  |
|--------------|----------------------------------------|
| sessionToken |   a1fa59e79bba1a38bb0684d3298c9ddd     |
|______________|________________________________________|
```

When we refresh the page, we should be taken to the admin page:
which we will find a message probably from a system admin.
He says that a username on the server is `stevenirate` and that the password is in rockyou.txt

If we look back to our nmap scan we can see that there is port 22 that allows the ssh protocol. Therefore, what if we try to login to the server, using `stevenirate` as the username and attempt to brute force the password?

For this, Hydra appears to be the best solution.
Hydra is a tool that specialises in brute forcing and ssh is one of it's specialties.

Open up the terminal and enter the following command. 
```
hydra -l stevenirate -P ./passwd_list.txt {ip address} ssh -I
```
where:
- `hydra` is the command we're using
- `-l` specifies that we are entering the login
    - `stevenirate` is the username we are supplying
- `-P` specifies that we are entering a text file full of possible passwords (the modified rockyou.txt)
    - `./passwd_list.txt` is the modified rockyou.txt file that we are inputing
- `{ip address}` is where we are entering the ip address of the server
- `ssh` tells hydra that we want to attack an ssh protocol port
- `-I` means that we don't want to resume a previous task

After some time we should we some green text telling us the credentials
`[22][ssh] host: {ip address}    login: stevenirate     password: georgia`
Now that we have the username and password of the machine, let's try these credentials
By entering the following command, we can see if we can gain access
```
ssh stevenirate@{ip address}
yes
georgia
```
We will be greeted by an ubuntu message.
If we have a look at our current working directory
```
ls
```
There is a flag called `flag.txt`
Let's have a look in it.
```
cat flag.txt
```
and there is our flag.

<h2>Congratulations. You win</h2>

