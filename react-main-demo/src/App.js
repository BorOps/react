import logo from './logo.svg';
import './App.css';
import React, { useState, useEffect } from 'react';


function App() {
  const [config, setConfig] = useState({});

  useEffect(() => {
    fetch('assets/config/appconfig.json')
      .then((response) => response.json())
      .then((data) => {
        console.log(data);
        setConfig(data);
      });
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <p>Hello world, from Boro </p>
        <p>
          Config value: {config.welcomeMsg}
        </p>
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;
