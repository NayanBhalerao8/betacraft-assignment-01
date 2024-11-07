// ShowProject.tsx
import React, { useState, useEffect } from 'react';
import { useParams } from 'react-router-dom';
import axios from 'axios';
import TaskCreate from './TaskCreate';
import TaskComments from './TaskComments';

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

const ShowProject = () => {
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
  const csrfToken = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content');

  const updateTask = (projectId: number, taskId: number, completed: boolean) => {
    axios
      .put(
        `/api/v1/projects/${projectId}/tasks/${taskId}`,
        { task: { completed } },
        { headers: { 'X-CSRF-Token': csrfToken || '' } }
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
        console.error('Error updating task:', error);
      });
  };

  if (loading) return <div>Loading...</div>;
  if (!project) return <div>Project not found</div>;

  return (
    <div>
      <h1>Project - {project.name}</h1>
      <p>Description - {project.description}</p>

      <h2>Tasks</h2>
      {project.tasks && project.tasks.length > 0 ? (
        project.tasks.map((task) => (
          <div key={task.id}>
            <h3>{task.title}</h3>
            <p>Completed: {task.completed ? "Yes" : "No"}</p>
             Mark as Completed: <input
              type="checkbox"
              checked={task.completed}
              onChange={(e) => updateTask(project.id, task.id, e.target.checked)}
            />

            {/* Add Task Comments Section */}
            <TaskComments taskId={task.id} projectId={project.id} /> {/* Ensure projectId is passed correctly */}
          </div>
        ))
      ) : (
        <p>No tasks available.</p>
      )}

      {/* Task Creation */}
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
