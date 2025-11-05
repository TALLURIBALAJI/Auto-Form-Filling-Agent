#!/usr/bin/env bash
# Build script for Render

set -o errexit

# Install Python dependencies
pip install --upgrade pip
pip install -r backend/requirements.txt

# Install Node.js dependencies
cd frontend
npm install

# Build React app
npm run build
cd ..
