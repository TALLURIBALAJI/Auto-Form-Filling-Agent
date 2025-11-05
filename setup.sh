#!/bin/bash
# Complete setup script for Auto Form Filling Agent

echo "🚀 Setting up Auto Form Filling Agent..."

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "📦 Creating Python virtual environment..."
    python3 -m venv venv
fi

# Activate virtual environment
echo "🔧 Activating virtual environment..."
source venv/bin/activate

# Install backend dependencies
echo "📥 Installing Python dependencies..."
pip install -r backend/requirements.txt

# Install frontend dependencies
echo "📥 Installing Node.js dependencies..."
cd frontend
npm install
cd ..

# Check for ChromeDriver
echo "🌐 Checking ChromeDriver installation..."
if command -v chromedriver &> /dev/null; then
    echo "✅ ChromeDriver is installed"
else
    echo "⚠️  ChromeDriver not found. Install with:"
    echo "   macOS: brew install chromedriver"
    echo "   Ubuntu: sudo apt-get install chromium-chromedriver"
fi

# Check environment file
if [ ! -f "backend/.env" ]; then
    echo "🔑 Creating environment file template..."
    echo "OPENROUTER_API_KEY=your_own_open_router_api_key" > backend/.env
    echo "LLAMA_CLOUD_API_KEY=your_own_llama_cloud_api_key" >> backend/.env
    echo "⚠️  Please update backend/.env with your API keys"
fi

echo ""
echo "✅ Setup complete!"
echo "🛠️  Next steps:"
echo "1. Update API keys in backend/.env"
echo "2. Run backend: source venv/bin/activate && cd backend && python main.py"
echo "3. Run frontend: cd frontend && npm start"
