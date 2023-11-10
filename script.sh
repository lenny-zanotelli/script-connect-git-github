echo
echo "Welcome this Git and Github config script"
echo
echo "To generate SSH Key, you need your github username and email."

# username github

username=""
while [ -z $username ]
do
  echo
  read -p " 1. What's your github username : " username
  if [ -z "$username" ]
  then
    echo
    echo "Username must be provided."
  fi
done

# email github
email=""
while [ -z $email ]
do
  echo
  read -p " 2. What's your github email : " email
  if [ -z "$email" ]
  then
    echo
    echo " Email must be provided."
  fi
done

# Checking informations provided
echo
echo "    Username : $username"
echo "    Email : $email"

echo
read -p " 3. Is this informations accurate ? (y/n) : " confirm

if [ "$confirm" != "y" ]
then
  echo
  echo "  The key could not be generated. Please run the script again to try again."
  exit 0;
else
  # Git Config
  echo
  echo " 4. Git Settings"
  echo
  git config --global user.name "$username"
  git config --gobal user.email "$email"
  git config --global core.editor nano
  git config --global color.ui true
  git config -l

  # Creating SSH Keys
  echo
  echo " 5. Generating Ssh Keys"
  ssh-keygen -t ed25519 -N '' -C "$email" -f ~/.ssh/id_ed25519 <<< y
fi

# Checking that the file containing the key exists
if [ -f ~/.ssh/id_ed25519.pub ]
then
  echo
  echo " 6. Here is your public key: "echo echo " -> copy the WHOLE line starting with ssh-ed25519..."
  echo " -> paste it into the Github interface (Settings >SSH and GPG keys > New SSH key, in the \"Key\"field)"
  echo "=========================="
  cat ~/.ssh/id_ed25519.pub
  echo "=========================="
fi

