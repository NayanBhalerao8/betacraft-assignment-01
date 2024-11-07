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

interface Comment {
  content: string;
  user_id: number; // Assuming user_id is required, adjust as needed
}

const TaskCreate: React.FC<TaskCreateProps> = ({ projectId, taskId, onTaskCreated }) => {
  const [title, setTitle] = useState<string>('');
  const [description, setDescription] = useState<string>('');
  const [completed, setCompleted] = useState<boolean>(false);
  const [commentContent, setCommentContent] = useState<string>('');  // For comment content
  const [userId, setUserId] = useState<number>(1); // Assuming a static user ID for now, adjust as needed


  const handleSubmit = (e: FormEvent) => {
    e.preventDefault();
  
    const csrfTokenMeta = document.querySelector('meta[name="csrf-token"]');
    let csrfToken = csrfTokenMeta ? csrfTokenMeta.getAttribute('content') : null;
  
    if (csrfTokenMeta) {
      csrfToken = csrfTokenMeta.getAttribute('content');
    } else {
      console.error('CSRF token meta tag not found!');
    }
  
    // Prepare comment data
    const commentData = {
        content: commentContent,  // The comment text
        user_id: userId,          // The user ID (ensure it's valid)
      };
      
  
    // Send POST request to create a comment
    axios.post(`/api/v1/projects/${projectId}/tasks/${taskId}/comments`, { comment: commentData }, {
        headers: {
            'X-CSRF-Token': csrfToken,
        },
    })      
           
    .then((response) => {
      console.log("Comment created:", response.data);
    })
    .catch((error) => {
      console.error("Error creating comment:", error);
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
      
      {/* Add Comment Section */}
      <label>
        Comment:
        <input 
          type="text" 
          value={commentContent} 
          onChange={(e) => setCommentContent(e.target.value)} 
          required 
        />
      </label>

      <button type="submit">Create Task and Comment</button>
    </form>
  );
};

export default TaskCreate;
