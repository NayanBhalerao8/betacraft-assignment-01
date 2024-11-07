import React, { useState, FormEvent } from 'react';
import axios from 'axios';

interface Comment {
  id: number;
  content: string;
  user_name: string;
  created_at: string;
  updated_at: string;
}

interface CommentCreateProps {
  taskId: number;
  onCommentCreated: (newComment: Comment) => void;
}

const CommentCreate: React.FC<CommentCreateProps> = ({ taskId, onCommentCreated }) => {
  const [content, setContent] = useState<string>('');

  const handleSubmit = (e: FormEvent) => {
    e.preventDefault();
  
    const csrfTokenMeta = document.querySelector('meta[name="csrf-token"]');
    let csrfToken: string | null = null;
  
    if (csrfTokenMeta) {
      csrfToken = csrfTokenMeta.getAttribute('content');
    } else {
      console.error('CSRF token meta tag not found!');
    }
  
    const commentData = { content };
  
    axios
      .post(
        `/api/v1/tasks/${taskId}/comments`,
        { comment: commentData },
        {
          headers: {
            'X-CSRF-Token': csrfToken,
          },
        }
      )
      .then((response) => {
        console.log('Comment added:', response.data);
        // Ensure response data has the correct type and passes it to onCommentCreated
        onCommentCreated(response.data as Comment);
        setContent('');
      })
      .catch((error) => {
        console.error('Error adding comment:', error);
      });
  };
  

  return (
    <form onSubmit={handleSubmit}>
      <label>
        Comment:
        <textarea
          value={content}
          onChange={(e) => setContent(e.target.value)}
          required
        />
      </label>
      <button type="submit">Add Comment</button>
    </form>
  );
};

export default CommentCreate;
