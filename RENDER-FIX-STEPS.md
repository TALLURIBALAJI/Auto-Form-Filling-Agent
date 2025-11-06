# RENDER DEPLOYMENT - EXACT STEPS TO FIX

## 🚀 DO THESE STEPS EXACTLY:

### Step 1: Push New Files
```bash
cd C:\Users\venki\OneDrive\Desktop\ROUTER\automatic-job-application-filler
git add render-build.sh render-start.sh
git commit -m "Add simplified Render deployment scripts"
git push
```

### Step 2: Go to Render Dashboard
https://dashboard.render.com/

### Step 3: Click on "auto-form-filler" service

### Step 4: Click "Settings" (left sidebar)

### Step 5: Update These Settings:

**Build Command:** (Delete everything and paste this)
```
bash render-build.sh
```

**Start Command:** (Delete everything and paste this)
```
cd backend && python -m uvicorn main:app --host 0.0.0.0 --port $PORT
```

### Step 6: Scroll down and click "Save Changes"

### Step 7: Go back to main service page

### Step 8: Click "Manual Deploy" → "Clear build cache & deploy"

### Step 9: Wait 10-15 minutes

---

## ✅ AFTER DEPLOYMENT:

Test these URLs:
1. https://auto-form-filling-agent.onrender.com/api/health
   - Should return: {"status":"healthy"}

2. https://auto-form-filling-agent.onrender.com
   - Should show the form upload page

---

## 🆘 IF IT STILL FAILS:

Send me a screenshot of the Render logs showing the error.
