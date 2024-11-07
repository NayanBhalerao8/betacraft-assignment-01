// App.tsx
import React from "react";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import "./App.css";
import Projects from "./Components/Projects";
import ShowProject from "./Components/ShowProject";
import InviteUserForm from "./Components/InviteUserForm";
import InviteResponse from "./Components/InviteResponse";


const App = () => {
  return (
    <BrowserRouter>
      <Routes>
        
        <Route path="/projects" element={<Projects />} /> {/* This is important */}
        <Route path="/projects/:id" element={<ShowProject />} />
        <Route path="/projects/:id/invite_others" element={<InviteUserForm />} />
        <Route path="/check_invites" element={<InviteResponse />} />
      </Routes>
    </BrowserRouter>
  );
};

export default App;
