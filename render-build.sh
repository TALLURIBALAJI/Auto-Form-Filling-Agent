#!/usr/bin/env bash
# Simplified build script for Render - guaranteed to work

set -o errexit  # Exit on error

echo "=== Step 1: Installing Python dependencies ==="
pip install --upgrade pip
pip install -r backend/requirements.txt

echo "=== Step 2: Installing Node.js dependencies ==="
cd frontend
npm ci --legacy-peer-deps

echo "=== Step 3: Building React frontend ==="
# Force production build without any environment variables
CI=false npm run build

echo "=== Step 4: Build complete! ==="
ls -la build/
cd ..
