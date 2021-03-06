controller :issues do

  action :all do
    action do
      issues = Issue.ordered.includes(:service_status, :user)
      issues.map { |i| structure(i, :full => true, :expansions => [:user, :service_status]) }
    end
  end

  action :create do
    param :title, :required => true, :type => String
    param :initial_update, :required => false, :type => String
    param :state, :required => false, :type => String
    param :services, :required => true, :type => Array
    param :status, :required => true, :type => String
    param :notify, :required => false
    param :minor_email, :required => false
    param :major_email, :required => false
    param :critical_email, :required => false

    action do
      issue_params = {
        title: params.title,
        initial_update: params.initial_update,
        state: params.state,
        service_ids: Service.where(permalink: params.services).pluck(:id),
        service_status_id: ServiceStatus.where(permalink: params.status).first.id,
        notify: params.notify,
        minor_email: params.minor_email,
        major_email: params.major_email,
        critical_email: params.critical_email
      }

      issue = Issue.new issue_params
      if issue.save
        structure issue, :full => true
      else
        error :validation_error, issue.errors
      end
    end
  end

  action :info do
    param :issue, :required => true, :type => Integer
    action do
      issue = Issue.find_by_id(params.issue)
      unless issue
        error :not_found, "Issue not found with ID `#{params.issue}`"
      end
      structure(issue, :full => true, :expansions => true)
    end
  end

  action :update do
    param :id, :required => true, :type => Integer
    param :text, :required => false, :type => String
    param :state, :required => false, :type => String
    param :status, :required => false, :type => String
    param :notify, :required => false
    param :minor_email, :required => false
    param :major_email, :required => false
    param :critical_email, :required => false

    action do
      update_params = {
        text: params.text,
        state: params.state,
        service_status: ServiceStatus.where(permalink: params.status).first,
        notify: params.notify,
        minor_email: params.minor_email,
        major_email: params.major_email,
        critical_email: params.critical_email
      }.compact

      issue = Issue.find params.id
      update = issue.updates.build update_params

      if update.save
        structure update, :full => true
      else
        error :validation_error, update.errors
      end
    end
  end

end
