import axios from 'axios';

// Force using relative path in production
const API_BASE_URL = '/api';

console.log('API Base URL:', API_BASE_URL);

const api = axios.create({
  baseURL: API_BASE_URL,
  timeout: 60000,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Add response interceptor for debugging
api.interceptors.response.use(
  response => {
    console.log('API Success:', response);
    return response;
  },
  error => {
    console.error('API Error:', error.message);
    console.error('API Error Details:', error.response || error);
    return Promise.reject(error);
  }
);

export const parseResume = async (file) => {
  const formData = new FormData();
  formData.append('file', file);
  
  return api.post('/parse-resume', formData, {
    headers: {
      'Content-Type': 'multipart/form-data',
    },
  });
};

export const analyzeForm = async (formUrl) => {
  return api.post('/analyze-form', { form_url: formUrl });
};

export const fillForm = async (file, formUrl) => {
  const formData = new FormData();
  formData.append('file', file);
  formData.append('form_url', formUrl);
  
  return api.post('/fill-form', formData, {
    headers: {
      'Content-Type': 'multipart/form-data',
    },
  });
};

export const healthCheck = async () => {
  return api.get('/health');
};