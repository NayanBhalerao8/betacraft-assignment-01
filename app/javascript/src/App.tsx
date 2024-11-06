import React from "react"
import { BrowserRouter, Route, Routes } from 'react-router-dom'
import "./App.css"
import Projects from "./Components/Projects"

const App = () => {
  return (
    <>
      <BrowserRouter>
        <Routes>
        <Route path="/" element={<Projects />} />
        </Routes>
      </BrowserRouter>
    </>
  )
}

export default App
