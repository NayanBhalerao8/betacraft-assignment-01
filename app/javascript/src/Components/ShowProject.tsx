import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import axios from 'axios';
import TaskCreate from './TaskCreate';

interface Task {
  id: number;
  title: string;
  completed: boolean;
}

interface Project {
  id: number;
  name: string;
  description: string;
  tasks: Task[];
}

const ShowProject: React.FC = () => {
  const { id } = useParams<{ id: string }>(); // specify route param type
  const [project, setProject] = useState<Project | null>(null);
  const [loading, setLoading] = useState(true);

  // Fetch project data
  useEffect(() => {
    if (!id) return; // Ensure `id` is defined before making the request

    axios.get(`/api/v1/projects/${id}`)
      .then((response) => {
        const projectData = response.data as Project; // Cast response data to Project type
        setProject(projectData);
        setLoading(false);
      })
      .catch((error) => {
        console.error("Error fetching project:", error);
        setLoading(false);
      });
  }, [id]);

  // Callback function to update tasks
  const addTaskToProject = (newTask: Task) => {
    setProject((prevProject) => {
      if (!prevProject) return prevProject;
      return { ...prevProject, tasks: [...prevProject.tasks, newTask] };
    });
  };

  if (loading) return <div>Loading...</div>;
  if (!project) return <div>Project not found</div>;

  return (
    <div>
      <h1>{project.name}</h1>
      <p>{project.description}</p>

      <h2>Tasks</h2>
      {project.tasks.length > 0 ? (
        project.tasks.map((task) => (
          <div key={task.id}>
            <h3>{task.title}</h3>
            <p>Completed: {task.completed ? "Yes" : "No"}</p>
          </div>
        ))
      ) : (
        <p>No tasks available.</p>
      )}

      {/* Task creation component with callback to add task */}
      <TaskCreate projectId={id || ''} onTaskCreated={addTaskToProject} />
    </div>
  );
};

export default ShowProject;
