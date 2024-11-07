import React, { useState, FormEvent } from 'react';
import axios from 'axios';

interface TaskCreateProps {
    projectId: string;
    onTaskCreated: (newTask: Task) => void;
    taskId?: string;  // Make taskId optional
}
  

interface Task {
  id: number;
  title: string;
  description: string;
  completed: boolean;
}

const TaskCreate: React.FC<TaskCreateProps> = ({ projectId, taskId, onTaskCreated }) => {
  const [title, setTitle] = useState<string>('');
  const [description, setDescription] = useState<string>('');
  const [completed, setCompleted] = useState<boolean>(false);

  const handleSubmit = (e: FormEvent) => {
    e.preventDefault();
  
    const csrfTokenMeta = document.querySelector('meta[name="csrf-token"]');
    let csrfToken = csrfTokenMeta ? csrfTokenMeta.getAttribute('content') : null;
  
    if (csrfTokenMeta) {
      csrfToken = csrfTokenMeta.getAttribute('content');
    } else {
      console.error('CSRF token meta tag not found!');
    }
  
    const taskData = {
        title,
        description,
        completed
    };
  
    // Send POST request to create a task
    axios.post<Task>(`/api/v1/projects/${projectId}/tasks`, taskData, {
        headers: {
            'X-CSRF-Token': csrfToken,
        },
    })      
    .then((response) => {
      console.log("Task created:", response.data);
      onTaskCreated(response.data); // Pass the new task to the parent component
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
