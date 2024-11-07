import React, { useState, FormEvent } from 'react';
import axios from 'axios';

interface TaskCreateProps {
  projectId: string;
  onTaskCreated: (newTask: Task) => void;
}

interface Task {
  id: number;
  title: string;
  description: string;
  completed: boolean;
}

const TaskCreate: React.FC<TaskCreateProps> = ({ projectId, onTaskCreated }) => {
  const [title, setTitle] = useState<string>('');
  const [description, setDescription] = useState<string>('');
  const [completed, setCompleted] = useState<boolean>(false);

  const handleSubmit = (e: FormEvent) => {
    e.preventDefault();

    const csrfTokenMeta = document.querySelector('meta[name="csrf-token"]');
    let csrfToken: string | null = null;

    if (csrfTokenMeta) {
      csrfToken = csrfTokenMeta.getAttribute('content');
    } else {
      console.error('CSRF token meta tag not found!');
    }

    // Prepare task data
    const taskData: Omit<Task, 'id'> = { title, description, completed };

    // Send POST request
    axios.post(`/api/v1/projects/${projectId}/tasks`, { task: taskData }, {
      headers: {
        'X-CSRF-Token': csrfToken,
      },
    })
    .then((response) => {
      console.log("Task created:", response.data);
      // Cast response.data to Task type
      onTaskCreated(response.data as Task);
      setTitle('');
      setDescription('');
      setCompleted(false);
    })
    .catch((error) => {
      console.error("Error creating task:", error);
    });
  };

  return (
    <form onSubmit={handleSubmit}>
      <label>
        Title:
        <input 
          type="text" 
          value={title} 
          onChange={(e) => setTitle(e.target.value)} 
          required 
        />
      </label>
      <label>
        Description:
        <input 
          type="text" 
          value={description} 
          onChange={(e) => setDescription(e.target.value)} 
          required 
        />
      </label>
      <label>
        Completed:
        <input 
          type="checkbox" 
          checked={completed} 
          onChange={(e) => setCompleted(e.target.checked)} 
        />
      </label>
      <button type="submit">Create Task</button>
    </form>
  );
};

export default TaskCreate;
