#!/bin/bash

sudo apt-get update
sudo apt-get install apache2 -y
sudo systemctl start apache2
sudo systemctl enable apache2
sudo rm /var/www/html/index.html
sudo timedatectl set-timezone Africa/Lagos

cat <<EOL > index.html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Random Color generator</title>
    <style>
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
      <div class="color-container">#7652a6</div>
      <div class="color-container">#7652a6</div>
      <div class="color-container">#7652a6</div>
      <div class="color-container">#7652a6</div>
    </div>

    <script>
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
          const randomNum = $((RANDOM % ${#chars}));
          colorCode+="${chars:randomNum:1}"
        }
        return colorCode;
      }
    </script>
  </body>
</html>
EOL

echo "<h2>$HOSTNAME</h2>" >> index.html

sudo mv index.html /var/www/html
sudo chown root:root /var/www/html/index.html
