const express = require('express');
const app = express();

app.use(express.json());

// Mock API responses
const mockData = {
  websiteInfo: {
    code: 200,
    data: {
      websiteName: 'Roncoo Education',
      websiteDesc: '领课网络在线教育系统 - 开源教育平台',
      websiteLogo: '/logo.png',
      websiteKeywords: '在线教育,开源教育,roncoo'
    }
  },
  carouselList: {
    code: 200,
    data: []
  },
  categoryList: {
    code: 200,
    data: []
  },
  zoneList: {
    code: 200,
    data: {
      list: [],
      total: 0
    }
  },
  websiteNav: {
    code: 200,
    data: []
  },
  websiteLink: {
    code: 200,
    data: []
  }
};

// API routes
app.get('/system/api/sys/config/website', (req, res) => {
  res.json(mockData.websiteInfo);
});

app.get('/system/api/website/carousel/list', (req, res) => {
  res.json(mockData.carouselList);
});

app.get('/course/api/category/list', (req, res) => {
  res.json(mockData.categoryList);
});

app.post('/course/api/zone/list', (req, res) => {
  res.json(mockData.zoneList);
});

app.get('/system/api/website/nav/list', (req, res) => {
  res.json(mockData.websiteNav);
});

app.get('/system/api/website/link/list', (req, res) => {
  res.json(mockData.websiteLink);
});

app.post('/system/api/common/enum', (req, res) => {
  res.json({ code: 200, data: {} });
});

// Catch all other routes
app.use('*', (req, res) => {
  res.status(404).json({ code: 404, message: 'API not found' });
});

const PORT = process.env.API_PORT || 3001;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Mock API server running on port ${PORT}`);
});