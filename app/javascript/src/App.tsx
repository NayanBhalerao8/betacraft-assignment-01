import React from "react"
import { BrowserRouter, Route, Routes } from 'react-router-dom'
import "./App.css"

const App = () => {
  return (
    <>
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<div className="container"><h1 className="greeting">Hello World!!</h1></div>} />
        </Routes>
      </BrowserRouter>
    </>
  )
}

export default App
