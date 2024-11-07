// App.tsx
import React from "react";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import "./App.css";
import Projects from "./Components/Projects";
import ShowProject from "./Components/ShowProject";

const App = () => {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Projects />} />
        <Route path="/projects" element={<Projects />} /> {/* This is important */}
        <Route path="/projects/:id" element={<ShowProject />} />
      </Routes>
    </BrowserRouter>
  );
};

export default App;
