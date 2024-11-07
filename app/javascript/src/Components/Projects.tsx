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
  const [newProject, setNewProject] = useState<{ name: string; description: string }>({
    name: '',
    description: '',
  });
  const [isSubmitting, setIsSubmitting] = useState<boolean>(false);

  // Fetch existing projects
  useEffect(() => {
    fetch("/api/v1/projects")
      .then((response) => {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        return response.json(); // Get parsed JSON response
      })
      .then((data) => setProjects(data))
      .catch((error) => {
        console.error("Error fetching projects:", error);
        setError("Failed to fetch projects.");
      });
  }, []);

  // Handle form input changes
  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    const { name, value } = e.target;
    setNewProject({ ...newProject, [name]: value });
  };

  // Submit new project
  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);

    fetch('/api/v1/projects', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        // Add the token if needed for authentication
        'Authorization': `Bearer ${localStorage.getItem('jwt_token')}`,
      },
      body: JSON.stringify({
        project: newProject,
      }),
    })
      .then((response) => response.json())
      .then((data) => {
        setProjects((prevProjects) => [...prevProjects, data]);
        setNewProject({ name: '', description: '' }); // Clear form
        setIsSubmitting(false);
      })
      .catch((error) => {
        console.error("Error creating project:", error);
        setError("Failed to create project.");
        setIsSubmitting(false);
      });
  };

  if (error) {
    return <div>Error: {error}</div>;
  }

  return (
    <div>
      <h2>Projects</h2>

      {/* Create New Project Form */}
      <form onSubmit={handleSubmit}>
        <div>
          <label htmlFor="name">Project Name:</label>
          <input
            type="text"
            id="name"
            name="name"
            value={newProject.name}
            onChange={handleInputChange}
            required
          />
        </div>
        <div>
          <label htmlFor="description">Project Description:</label>
          <textarea
            id="description"
            name="description"
            value={newProject.description}
            onChange={handleInputChange}
            required
          />
        </div>
        <button type="submit" disabled={isSubmitting}>
          {isSubmitting ? 'Creating...' : 'Create Project'}
        </button>
      </form>

      {projects.length === 0 ? (
        <p>No projects available</p>
      ) : (
        <ul>
          {projects.map((project) => (
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
};

export default Projects;
