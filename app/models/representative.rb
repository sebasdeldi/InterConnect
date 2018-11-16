class Representative

 def self.fetch_tasks(params, current_user, date_range_param)
   if ((params[:operation_id] == 'ALL' || params[:operation_id].nil?) && (params[:task_subject] == 'ALL' || params[:task_subject].nil?))
     Task.get_data(current_user, date_range_param)
   elsif ((params[:operation_id] != 'ALL' && !params[:operation_id].nil?) && (params[:task_subject] == 'ALL' || params[:task_subject].nil?))
     Task.get_data(current_user, date_range_param).where(operation_id: params[:operation_id])
   elsif ((params[:operation_id] == 'ALL' || params[:operation_id].nil?) && (params[:task_subject] != 'ALL' && !params[:task_subject].nil?))
     Task.get_data(current_user, date_range_param).where(subject: params[:task_subject])
   elsif ((params[:operation_id] != 'ALL' || !params[:operation_id].nil?) && (params[:task_subject] != 'ALL' && !params[:task_subject].nil?))
     Task.get_data(current_user, date_range_param).where(subject: params[:task_subject], operation_id: params[:operation_id])
   end
 end
end
