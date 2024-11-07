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
    return <div className="text-red-500">{error}</div>;
  }

  return (
    <div className="container mx-auto p-6">
      <h2 className="text-3xl font-semibold mb-8">Projects  : </h2>

      {/* Create New Project Form */}
      <form onSubmit={handleSubmit} className="bg-white p-8 rounded-lg shadow-md mb-8 w-full">
        <div className="mb-6">
          <label htmlFor="name" className="block text-lg font-medium mb-2">Project Name:</label>
          <input
            type="text"
            id="name"
            name="name"
            value={newProject.name}
            onChange={handleInputChange}
            required
            className="p-3 border border-gray-300 rounded w-full focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </div><br></br>
        <div className="mb-6">
          <label htmlFor="description" className="block text-lg font-medium mb-2">Project Description:</label>
          <textarea
            id="description"
            name="description"
            value={newProject.description}
            onChange={handleInputChange}
            required
            className="p-3 border border-gray-300 rounded w-full focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </div><br></br>
        <button
          type="submit"
          disabled={isSubmitting}
          className="w-full py-3 px-4 bg-blue-500 text-white rounded hover:bg-blue-700 disabled:bg-gray-400 transition duration-200"
        >
          {isSubmitting ? 'Creating...' : 'Create Project'}
        </button>
      </form>

      {/* Projects List */}
      {projects.length === 0 ? (
        <p className="text-gray-500">No projects available</p>
      ) : (
        <ul className="space-y-6">
          {projects.map((project) => (
            <li key={project.id} className="bg-white p-6 rounded-lg shadow-md">
              <h3 className="text-xl font-semibold">{project.name}</h3>
              <p className="text-gray-700 mt-2">{project.description}</p>
              <small className="text-gray-500 block mt-2">Created at: {new Date(project.created_at).toLocaleDateString()}</small>
              <Link
                to={`/projects/${project.id}`}
                className="text-blue-500 hover:text-blue-700 mt-4 inline-block"
              ><br></br>
                View Project
              </Link>
            </li>
          ))}
        </ul>
      )}
    </div>


  );
};

export default Projects;
