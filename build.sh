#!/usr/bin/env bash
# Build script for Render

set -o errexit

echo "Installing backend dependencies..."
pip install --upgrade pip
pip install -r backend/requirements.txt

echo "Installing frontend dependencies..."
cd frontend
npm ci --no-audit --no-fund

echo "Building frontend..."
npm run build

echo "Build completed successfully!"
