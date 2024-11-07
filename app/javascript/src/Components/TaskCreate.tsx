import React, { useState, FormEvent } from 'react';
import axios from 'axios';

interface Task {
  id: number;
  title: string;
  description: string;
  completed: boolean;
}

interface TaskCreateProps {
  projectId: string;
  onTaskCreated: (newTask: Task) => void; // Declare the `onTaskCreated` prop here
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

    // Prepare task data without 'id'
    const taskData: Omit<Task, 'id'> = { title, description, completed }; 

    // Send POST request
    axios.post(`/api/v1/projects/${projectId}/tasks`, 
      { task: taskData },
      {
        headers: {
          'X-CSRF-Token': csrfToken, // Include CSRF token in the headers
        },
      }
    )
    .then((response) => {
        console.log("Task created:", response.data);
      
        // Type assertion to indicate that response.data is of type Task
        const newTask = response.data as Task;
      
        // Call the parent callback to update the task list
        onTaskCreated(newTask); 
      
        setTitle('');
        setDescription('');
        setCompleted(false);
      })      
    .catch((error) => {
      console.error("Error creating task:", error);
      console.log("Response data:", error.response?.data);
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
