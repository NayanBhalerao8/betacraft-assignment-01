import React, { useState, useEffect } from 'react';
import axios from 'axios';

interface Comment {
  id: number;
  text: string;
}

interface TaskCommentsProps {
  taskId: number;
}

const TaskComments: React.FC<TaskCommentsProps> = ({ taskId }) => {
  const [comments, setComments] = useState<Comment[]>([]);
  const [newComment, setNewComment] = useState('');
  const [loading, setLoading] = useState(true);

  // Fetch comments for the specific task
  useEffect(() => {
    axios.get(`/api/v1/tasks/${taskId}/comments`)
      .then((response) => {
        setComments(Array.isArray(response.data) ? response.data : []);
        setLoading(false);
      })
      .catch((error) => {
        console.error('Error fetching comments:', error);
        setLoading(false);
        setComments([]);
      });
  }, [taskId]);

  // Handle new comment submission
  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();

    if (newComment.trim()) {
      axios.post(`/api/v1/tasks/${taskId}/comments`, { comment: { text: newComment } })
        .then((response) => {
          // Ensure the new comment is typed as Comment
          const newCommentData = response.data as Comment;
          setComments((prevComments) => [...prevComments, newCommentData]); // Update state with correct type
          setNewComment(''); // Reset the input field
        })
        .catch((error) => {
          console.error('Error adding comment:', error);
        });
    }
  };

  if (loading) return <div>Loading comments...</div>;

  return (
    <div>
      <h4>Comments</h4>
      {comments.length === 0 ? (
        <p>No comments available.</p>
      ) : (
        <ul>
          {comments.map((comment) => (
            <li key={comment.id}>{comment.text}</li>
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
