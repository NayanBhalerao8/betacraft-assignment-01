def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      render 'api/v1/tasks/update', status: :ok
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
end
  