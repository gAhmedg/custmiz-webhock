#!/bin/bash

# Use the REPO_URL and REPO_DIR environment variables, with default values
REPO_URL=${REPO_URL:-https://github.com/gAhmedg/helm.git}
REPO_DIR=${REPO_DIR:-helm}

# Check if the directory exists
if [ -d "$REPO_DIR" ]; then
  echo "Directory $REPO_DIR already exists."

  # Check if it's a Git repository
  if [ -d "$REPO_DIR/.git" ]; then
    echo "Directory $REPO_DIR is a valid Git repository."

    # Verify the remote URL
    CURRENT_URL=$(git -C "$REPO_DIR" config --get remote.origin.url)
    if [ "$CURRENT_URL" == "$REPO_URL" ]; then
      echo "Repository matches $REPO_URL. Updating repository..."
      cd "$REPO_DIR" || exit
      git fetch --all
      git reset --hard origin/main  # Replace 'main' with your branch name
      echo "Repository updated successfully!"
      exit 0
    else
      echo "Repository does not match $REPO_URL. Overwriting the folder..."
    fi
  else
    echo "Directory $REPO_DIR exists but is not a Git repository. Overwriting the folder..."
  fi

  # Remove the folder to overwrite
  rm -rf "$REPO_DIR"
fi

# Clone the repository
echo "Cloning the repository from $REPO_URL into $REPO_DIR..."
git clone "$REPO_URL" "$REPO_DIR"
echo "Repository cloned successfully!"

# Navigate to the repository
cd "$REPO_DIR" || exit

# Fetch the latest changes
echo "Pulling latest changes from the repository..."
git fetch --all
git reset --hard origin/main  # Replace 'main' with your branch name

echo "Repository updated successfully!"
