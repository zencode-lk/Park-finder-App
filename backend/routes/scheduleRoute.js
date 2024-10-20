const express = require('express');
const router = express.Router();
const scheduleController = require('../controllers/scheduleController'); 

router.post('/create', scheduleController.createSchedule);
router.get('/data/:userId', scheduleController.getProfileSchedules);
module.exports = router;
