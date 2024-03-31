#!/bin/bash

# Update packages
sudo yum update

# Install Apache (httpd)
sudo yum install httpd -y

# Start and enable Apache service
sudo systemctl start httpd
sudo systemctl enable httpd

# Remove the default index.html file
sudo rm /var/www/html/index.html

# Set the timezone to Africa/Lagos
sudo timedatectl set-timezone Africa/Lagos

# Create a new index.html file with your HTML content
cat <<EOL > index.html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Random Color generator</title>
    <style>
      /* Your CSS styles here */
      body {
        margin: 0;
        font-family: cursive;
      }
      h1 {
        text-align: center;
      }
      .container {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
      }
      .color-container {
        background-color: orange;
        width: 300px;
        height: 150px;
        color: white;
        margin: 5px;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 25px;
        text-shadow: 2px 4px rgba(0,0,0,0.5);
        border-radius: 10px;
      }
    </style>
  </head>
  <body>
    <h1>Random Color Generator</h1>
    <div class="container">
      <!-- Your color containers here -->
    </div>

    <script>
      // Your JavaScript code here
      const containerEl = document.querySelector(".container");

      for (let index = 0; index < 30; index++) {
        const colorContainerEl = document.createElement("div");
        colorContainerEl.classList.add("color-container");
        containerEl.appendChild(colorContainerEl);
      }

      const colorContainerEls = document.querySelectorAll(".color-container");

      generateColors();

      function generateColors() {
        colorContainerEls.forEach((colorContainerEl) => {
          const newColorCode = randomColor();
          colorContainerEl.style.backgroundColor = "#" + newColorCode ;
          colorContainerEl.innerText = "#" + newColorCode;
        });
      }

      function randomColor() {
        const chars = "0123456789abcdef";
        const colorCodeLength = 6;
        let colorCode = "";
        for (let index = 0; index < colorCodeLength; index++) {
          const randomNum = Math.floor(Math.random() * chars.length);
          colorCode+=chars.charAt(randomNum);
        }
        return colorCode;
      }
    </script>
  </body>
</html>
EOL

# Append the hostname to the HTML file
echo "<h2>$HOSTNAME</h2>" >> index.html

# Move the index.html file to /var/www/html/ or create the directory if it doesn't exist
sudo mv index.html /var/www/html/ || sudo mkdir -p /var/www/html/ && sudo mv index.html /var/www/html/

# Set ownership of the index.html file
sudo chown root:root /var/www/html/index.html
