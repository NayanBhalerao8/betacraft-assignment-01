import React, { useState, useEffect } from "react";
import axios from "axios";

interface Invite {
  id: number;
  project_name: string;
  status: string;
  user_email: string;
}

const InviteResponse: React.FC = () => {
  const [invites, setInvites] = useState<Invite[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Fetch invites for the logged-in user
    axios.get<Invite[]>("/api/v1/check_invites")
      .then((response) => {
        setInvites(response.data);  // TypeScript now knows this is an array of Invite objects
        setLoading(false);
      })
      .catch((error) => {
        console.error("Error fetching invites", error);
        setLoading(false);
      });
  }, []);

  const handleAccept = (id: number) => {
    // You should dynamically pass the project_id, e.g., via route params if needed
    const projectId = 4;  // This should ideally come from the state or URL params
  
    axios.post(`/api/v1/projects/${projectId}/invites/${id}/accept`)
      .then((response) => {
        console.log("Invite accepted:", response.data);
        setInvites(invites.filter(invite => invite.id !== id));
      })
      .catch((error) => {
        console.error("Error accepting invite", error);
      });
  };

  const handleReject = (id: number) => {
    axios.post(`/api/v1/projects/4/invites/${id}/reject`)
      .then((response) => {
        console.log("Invite rejected:", response.data);
        setInvites(invites.filter(invite => invite.id !== id));
      })
      .catch((error) => {
        console.error("Error rejecting invite", error);
      });
  };

  if (loading) return <div>Loading invites...</div>;

  return (
    <div>
      <h3>Your Invitations</h3>
      {invites.length === 0 ? (
        <p>No invitations found.</p>
      ) : (
        <ul>
          {invites.map((invite) => (
            <li key={invite.id}>
              You are invited to the project: {invite.project_name} BY {invite.user_email}
              {invite.status === "pending" && (
                <div>
                  <button onClick={() => handleAccept(invite.id)}>Accept</button>
                  <button onClick={() => handleReject(invite.id)}>Reject</button>
                </div>
              )}
            </li>
          ))}
        </ul>
      )}
    </div>
  );
};

export default InviteResponse;
