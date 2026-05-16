#!/usr/bin/env bash
set -e

GIT_NAME="${GIT_NAME:-$(
  read -rp 'Name: ' n
  echo "$n"
)}"
GIT_EMAIL="${GIT_EMAIL:-$(
  read -rp 'Email: ' e
  echo "$e"
)}"

# Берем Fingerprint (40 символов) из поля 10 (fpr)
GIT_GPG_KEY=$(gpg --list-secret-keys --with-colons 2>/dev/null | awk -F: '/^fpr:/ {print $10; exit}')

if [ -z "$GIT_GPG_KEY" ]; then
  echo "⚠️ GPG key not found. Signing disabled."
  git config --global commit.gpgsign false
else
  git config --global user.signingkey "$GIT_GPG_KEY"
  git config --global commit.gpgsign true
  echo "🔑 Found Key Fingerprint: $GIT_GPG_KEY"
fi

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
echo "✅ Git configured: $GIT_NAME <$GIT_EMAIL>"
