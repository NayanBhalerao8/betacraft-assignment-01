// src/Projects.tsx
import React, { useEffect, useState } from 'react'

interface Project {
  id: number;
  name: string;
  description: string;
  created_at: string;
  updated_at: string;
}

const Projects: React.FC = () => {
  const [projects, setProjects] = useState<Project[]>([])

  useEffect(() => {
    fetch("/api/v1/projects") // Adjust the URL based on your API route
      .then(response => response.json())
      .then(data => setProjects(data))
      .catch(error => console.error("Error fetching projects:", error))
  }, [])

  return (
    <div>
      <h2>Projects</h2>
      <ul>
        {projects.map(project => (
          <li key={project.id}>
            <h3>{project.name}</h3>
            <p>{project.description}</p>
            <small>Created at: {new Date(project.created_at).toLocaleDateString()}</small>
          </li>
        ))}
      </ul>
    </div>
  )
}

export default Projects
