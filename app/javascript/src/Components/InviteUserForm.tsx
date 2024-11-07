import React, { useState } from 'react';
import axios from 'axios';
import { useParams } from 'react-router-dom';

const InviteUserForm: React.FC = () => {
  const { id } = useParams<{ id: string }>(); // Get the project ID from the URL
  const projectId = parseInt(id!, 10); // Convert the ID to an integer (assuming it's a number)

  const [email, setEmail] = useState('');
  const [status, setStatus] = useState<string | null>(null);

  const handleInviteSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    
    if (email.trim()) {
      axios.post(`/api/v1/projects/${projectId}/invites`, { invite: { invitee_email: email } })
        .then(response => {
          setStatus('Invitation sent successfully');
          setEmail('');
        })
        .catch(error => {
          setStatus('Error sending invitation');
          console.error(error);
        });
    }
  };

  return (
    <div>
      <h4>Invite User to Project</h4>
      <form onSubmit={handleInviteSubmit}>
        <input
          type="email"
          placeholder="Enter email address"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
        />
        <button type="submit">Invite</button>
      </form>
      {status && <p>{status}</p>}
    </div>
  );
};

export default InviteUserForm;
