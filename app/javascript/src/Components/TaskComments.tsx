import React, { useState } from 'react';
import axios from 'axios';

interface Comment {
  id: number;
  content: string;
  user_name: string;
  created_at: string;
  updated_at: string;
}

interface TaskCommentsProps {
  taskId: string;
  projectId: string;
  comments: Comment[];  // Accepting comments as a prop
  onCommentAdded: (newComment: Comment) => void;
}

const TaskComments: React.FC<TaskCommentsProps> = ({ taskId, projectId, comments, onCommentAdded }) => {
  const [newComment, setNewComment] = useState('');

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    if (newComment.trim()) {
      axios
        .post(`/api/v1/projects/${projectId}/tasks/${taskId}/comments`, { comment: { content: newComment } })
        .then((response) => {
          const newCommentData = response.data as Comment;

          // Call the prop function to add the new comment
          onCommentAdded(newCommentData);

          setNewComment(''); // Reset input field after submission
        })
        .catch((error) => {
          console.error('Error adding comment:', error);
        });
    }
  };

  return (
    <div>
      <h2>Comments</h2>
      {comments.length === 0 ? (
        <p>No comments available.</p>
      ) : (
        <ul>
          {comments.map((comment) => (
            <li key={comment.id}>
              <strong>{comment.user_name}</strong> - {comment.created_at}
              <p>{comment.content}</p>
            </li>
          ))}
        </ul>
      )}

      {/* Comment input form */}
      <form onSubmit={handleSubmit}>
        <textarea
          value={newComment}
          onChange={(e) => setNewComment(e.target.value)}
          placeholder="Add a comment..."
          rows={3}
          style={{ width: '100%' }}
        />
        <button type="submit" disabled={!newComment.trim()}>
          Add Comment
        </button>
      </form>
    </div>
  );
};

export default TaskComments;
