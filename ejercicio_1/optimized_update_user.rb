def update_user user_data
  begin

    user = user_data[:id].nil? ? User.new : User.find(user_data[:id])

    if status = user.save
      if user_role.present? && process_id.present? && user_id.present?
        status = UserRoleProcess.find_or_create_by(user_id: user_id,role_id: user_role.to_i, enterprise_process_id: process_id.to_i)
      end
      if status && area_id.present?
        status = UserEnterpriseArea.find_or_create_by(user_id: user_id, enterprise_area_id: area_id.to_i)
      end
    end

    return status
  rescue Exception => e
    #Manejo de excepción
  end
end