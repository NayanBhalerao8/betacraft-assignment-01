import React, { useState, useEffect } from 'react';
import axios from 'axios';

interface Comment {
  id: number;
  content: string;
  user_name: string;
  created_at: string;
  updated_at: string;
}

interface TaskCommentsProps {
  taskId: number;
  projectId: number;
}

const TaskComments: React.FC<TaskCommentsProps> = ({ taskId, projectId }) => {
  const [comments, setComments] = useState<Comment[]>([]);
  const [newComment, setNewComment] = useState('');
  const [loading, setLoading] = useState(true);

  // Fetch comments for the specific task
  useEffect(() => {
    setLoading(true); // Set loading to true when fetching comments
    axios.get(`/api/v1/tasks/${taskId}/comments`)
      .then((response) => {
        setComments(Array.isArray(response.data) ? response.data : []);
        setLoading(false); // Set loading to false once data is fetched
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
      axios.post(`/api/v1/projects/${projectId}/tasks/${taskId}/comments`, { comment: { content: newComment } })
        .then((response) => {
          const newCommentData = response.data as Comment;
          setComments((prevComments) => [...prevComments, newCommentData]); // Add the new comment to the list
          setNewComment(''); // Reset input field after submission
        })
        .catch((error) => {
          console.error('Error adding comment:', error);
        });
    }
  };

  if (loading) return <div>Loading comments...</div>;

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
