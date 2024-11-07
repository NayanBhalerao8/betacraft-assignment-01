import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import axios from 'axios';
import TaskCreate from './TaskCreate';

interface Task {
  id: number;
  title: string;
  description: string;
  completed: boolean;
}

interface Project {
  id: number;
  name: string;
  description: string;
  tasks: Task[];
}

const ShowProject: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const [project, setProject] = useState<Project | null>(null);
  const [loading, setLoading] = useState(true);

  // Fetch project and tasks
  useEffect(() => {
    if (!id) return;
    axios.get(`/api/v1/projects/${id}`)
      .then((response) => {
        const projectData = response.data as Project;
        setProject(projectData);
        setLoading(false);
      })
      .catch((error) => {
        console.error("Error fetching project:", error);
        setLoading(false);
      });
  }, [id]);

  // Update task completion status
  const updateTask = (taskId: number, completed: boolean) => {
    const csrfTokenMeta = document.querySelector('meta[name="csrf-token"]');
    let csrfToken: string | null = null;

    if (csrfTokenMeta) {
      csrfToken = csrfTokenMeta.getAttribute('content');
    } else {
      console.error('CSRF token meta tag not found!');
    }

    axios.put(`/api/v1/projects/${id}/tasks/${taskId}`, 
      { task: { completed } },
      {
        headers: {
          'X-CSRF-Token': csrfToken,
        },
      }
    )
    .then((response) => {
      const updatedTask = response.data as Task;
      setProject((prevProject) => {
        if (prevProject) {
          const updatedTasks = prevProject.tasks.map((task) =>
            task.id === updatedTask.id ? updatedTask : task
          );
          return { ...prevProject, tasks: updatedTasks };
        }
        return prevProject;
      });
    })
    .catch((error) => {
      console.error("Error updating task:", error);
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
            <p>{task.description}</p>
            <p>Completed: {task.completed ? 'Yes' : 'No'}</p>
            <label>
              Completed:
              <input
                type="checkbox"
                checked={task.completed}
                onChange={(e) => updateTask(task.id, e.target.checked)}
              />
            </label>
          </div>
        ))
      ) : (
        <p>No tasks available.</p>
      )}

      {/* Pass the onTaskCreated prop to TaskCreate */}
      <TaskCreate
        projectId={id || ''}
        onTaskCreated={(newTask) => {
          setProject((prevProject) => {
            if (prevProject) {
              return { ...prevProject, tasks: [...prevProject.tasks, newTask] };
            }
            return prevProject;
          });
        }}
      />
    </div>
  );
};

export default ShowProject;
