import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';

interface Project {
  id: number;
  name: string;
  description: string;
  created_at: string;
  updated_at: string;
}

const Projects: React.FC = () => {
  const [projects, setProjects] = useState<Project[]>([]);
  const [error, setError] = useState<string | null>(null); // To handle errors

  useEffect(() => {
    fetch("/api/v1/projects")
      .then((response) => {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        return response.text(); // Get raw response text first
      })
      .then((text) => {
        try {
          const data = JSON.parse(text); // Attempt to parse as JSON
          setProjects(data);
        } catch (e) {
          setError("Failed to parse JSON response.");
        }
      })
      .catch((error) => {
        console.error("Error fetching projects:", error);
        setError("Failed to fetch projects.");
      });
  }, []);

  if (error) {
    return <div>Error: {error}</div>;
  }

  return (
    <div>
      <h2>Projects</h2>
      {projects.length === 0 ? (
        <p>No projects available</p>
      ) : (
        <ul>
          {projects.map(project => (
            <li key={project.id}>
              <h3>{project.name}</h3>
              <p>{project.description}</p>
              <small>Created at: {new Date(project.created_at).toLocaleDateString()}</small>
              <Link to={`/projects/${project.id}`}>View Project</Link>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}

export default Projects;
