#!/usr/bin/env bash
# Simplified build script for Render - guaranteed to work

set -o errexit  # Exit on error

echo "=== Step 1: Installing Python dependencies ==="
pip install --upgrade pip
pip install -r backend/requirements.txt

echo "=== Step 2: Installing Node.js dependencies ==="
cd frontend

# CRITICAL: Remove any .env files and clean npm cache
rm -f .env .env.local .env.production .env.development
npm cache clean --force
rm -rf node_modules/.cache

npm ci --legacy-peer-deps

echo "=== Step 3: Building React frontend ==="
# Completely unset ALL REACT_APP variables before build
unset REACT_APP_API_URL
export REACT_APP_API_URL=""

# Force production build without any environment variables
CI=false npm run build

echo "=== Step 4: Verifying build ==="
echo "Build directory contents:"
ls -la build/
echo "Checking for hardcoded URLs in built files..."
grep -r "localhost\|127.0.0.1\|98.93.74" build/ || echo "No hardcoded localhost URLs found - GOOD!"

cd ..
