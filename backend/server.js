const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const app = express();
const port = 3000;
const mongoose = require('mongoose');
const { CLOSING } = require('ws');

mongoose.connect('mongodb://localhost:27017/todo', { useNewUrlParser: true, useUnifiedTopology: true })
.then(()=> {
  console.log('connected');
})
.catch((error)=>{
  console.error("error while connecting")
})
const TaskSchema = new mongoose.Schema({
  // name: String,
  // age: Number,
  // email: String,
  task: String,
  date: Date  
});

const Task = mongoose.model('Task', TaskSchema); 
  // User.find()
  // .then((users) => {
  //   console.log('Users:', users);
  // })
  // .catch((error) => {
  //   console.error})
    
app.use(bodyParser.json());
app.use(cors());

// Sample route
app.get('/', (req, res) => {
  res.send('Hello from the backend!');
});

app.get('/items', async (req, res) => {
  try {
    const items = await Task.find();
    res.json(items);
  } catch (err) {
    res.status(500).send(err);
  }
});


// Sample POST route
app.post('/data', (req, res) => {
  const data = req.body.data; // Access the data sent from the app
  // const newTask = new Task({
  //   task: data[1],
  //   date:data[0]
  // });
  // newTask.save()
  //   .then(() => {
  //     console.log('Task created successfully');
  //   })
  //   .catch((error) => {
  //     console.error('Error creating Task:', error);
  //   });
  // Process the data (e.g., store it in a database)
  res.send('Data received!'); // Or send a different response based on processing
});

app.listen(3000, () => console.log('Server listening on port 3000'));