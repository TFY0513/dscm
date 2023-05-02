const express = require("express");
const path = require("path");
const multer = require('multer');
const app = express();

const fs = require('fs');
const directoryPath = path.join(__dirname, 'public', 'component', 'profile_sample');



//path to link css or png file
app.use(express.static('public/assets/bootstrap/css'));
app.use(express.static('public/assets/bootstrap/js'));
app.use(express.static('public/assets/css'));
app.use(express.static('public/component/logo'));
app.use(express.static('public/component/favicon'));
app.use(express.static('public/bootstrap/assets/dist/css'));
app.use(express.static('public/bootstrap/template'));
app.use(express.static('public/bootstrap/assets/dist/js'));
app.use(express.static('public/component/profile_sample'));
app.use(express.static('public/component/durianimg'));
app.use(express.static('public/contract'));
app.set('view engine', 'ejs');

app.engine('.ejs', require('ejs').__express);



// Set up multer storage
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'public/component/profile_sample/');
  },
  filename: function (req, file, cb) {
    const filename = req.params.fileName;
    cb(null, filename);

    // const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1e9);
    //cb(null, file.fieldname + '-' + uniqueSuffix + path.extname(file.originalname));


  }
});


const validateFileType = function (req, file, cb) {
  const allowedFileTypes = /jpeg|jpg|png/;
  const extname = allowedFileTypes.test(path.extname(file.originalname).toLowerCase());
  const mimetype = allowedFileTypes.test(file.mimetype);
  if (extname && mimetype) {
    cb(null, true);
  } else {

    cb('Error: Only jpeg, jpg, and png file types are allowed!');
  }
};

// Create multer instance
const upload = multer({
  storage: storage,
  fileFilter: validateFileType,
  limits: { fileSize: 10000000 } // Set file size limit to 100MB
});

app.get("/", (req, res) => {//"/" is route name
  // res.sendFile(path.join(__dirname + "/views/authentication/login.html"));
  res.render('home/Setting');
  // res.render('authentication/login');
});

app.get("/login", (req, res) => {//"/" is route name
  // res.sendFile(path.join(__dirname + "/views/authentication/login.html"));

  res.render('authentication/login');
});

app.get('/register', (req, res, next) => {//"/hello" is route name
  res.render('authentication/register');;
});

app.get('/index', (req, res, next) => {//"/hello" is route name
  res.render('authentication/index');;
});

app.get('/home', (req, res, next) => {//"/hello" is route name
  res.render('home/home');;
});

app.get('/profile', (req, res, next) => {//"/hello" is route name
  res.render('profile/profile');;
});


app.get('/farmerViewDurian', (req, res, next) => {//"/hello" is route name
  res.render('farmer/viewDurian');;
});


app.get('/distributerViewDurian', (req, res, next) => {//"/hello" is route name
  res.render('distributer/viewDurian');;
});

app.get('/retailerViewDurian', (req, res, next) => {//"/hello" is route name
  res.render('retailer/viewDurian');;
});

app.get('/clientViewDurian', (req, res, next) => {//"/hello" is route name
  res.render('clients/viewDurian');;
});
app.get('/history', (req, res, next) => {//"/hello" is route name
  res.render('clients/history');;
});
``

app.get('/signout', (req, res, next) => {//"/hello" is route name
  res.render('authentication/signout');;
});


const server = app.listen(5000);
const portNumber = server.address().port;
console.log(`port is open on ${portNumber}`);
