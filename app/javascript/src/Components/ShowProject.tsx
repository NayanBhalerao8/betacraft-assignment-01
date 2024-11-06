import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
// Define the Comment interface
interface Comment {
    id: number;
    content: string;
    user: {
      name: string;
    };
  }
  
  // Define the Task interface
  interface Task {
    id: number;
    title: string;
    completed: boolean;
    comments: Comment[];
  }
  
  interface Project {
    id: number;
    name: string;
    description: string;
    tasks: Task[];
  }
  
  const ShowProject: React.FC = () => {
    const { id } = useParams<{ id: string }>();
    const [project, setProject] = useState<Project | null>(null);
    const [tasks, setTasks] = useState<Task[]>([]);
  
    useEffect(() => {
      const fetchProject = async () => {
        try {
          const response = await fetch(`/api/v1/projects/${id}`);
          const data = await response.json();
          setProject(data.project);
          setTasks(data.tasks);
        } catch (error) {
          console.error("Error fetching project:", error);
        }
      };
  
      fetchProject();
    }, [id]);
  
    if (!project) return <p>Loading...</p>;
  
    return (
      <div>
        <h1>{project.name}</h1>
        <p>{project.description}</p>
  
        <h2>Tasks</h2>
        {tasks.length === 0 ? (
          <p>No tasks yet.</p>
        ) : (
          <ul>
            {tasks.map((task) => (
              <li key={task.id}>
                {task.title} - {task.completed ? "Completed" : "Pending"}
                
                <h3>Comments</h3>
                {task.comments.length === 0 ? (
                  <p>No comments yet.</p>
                ) : (
                  <ul>
                    {task.comments.map((comment) => (
                      <li key={comment.id}>
                        {comment.content} - {comment.user.name}
                      </li>
                    ))}
                  </ul>
                )}
              </li>
            ))}
          </ul>
        )}
      </div>
    );
  };
  
  export default ShowProject;  