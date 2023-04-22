const express = require("express");
const path = require("path");
const app = express();

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

app.set('view engine', 'ejs');

app.engine('.ejs', require('ejs').__express);


app.get("/", (req, res) => {//"/" is route name
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

app.get('/editProfile', (req, res, next) => {//"/hello" is route name
  res.render('profile/EditProfile');;
}); 


app.get('/test', (req, res, next) => {//"/hello" is route name
  res.render('authentication/test');;
}); 

// app.get('/hello', (req, res, next) => {//"/hello" is route name
//     res.send('Hello Express!');
// }); 


const server = app.listen(5000);
const portNumber = server.address().port;
console.log(`port is open on ${portNumber}`);
