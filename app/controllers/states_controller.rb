class StatesController < ApplicationController
  before_filter :get_state
  
  def show
    if @state.supported?
      @legislature = @state.legislature
      @most_recent_session = Session.most_recent(@legislature).first
      @state_lower_chamber_roles = @most_recent_session.roles.for_chamber(@legislature.lower_chamber).by_last_name
      @state_upper_chamber_roles = @most_recent_session.roles.for_chamber(@legislature.upper_chamber).by_last_name
      @federal_lower_chamber_roles = @state.us_rep_roles.order("people.last_name")

      @state_key_votes = Bill.all(:conditions => {:votesmart_key_vote => true, :chamber_id => @legislature.chambers})
    else
      render :template => 'states/unsupported'
    end
  end

  def subscribe
    if request.post?
      @state.subscriptions.build(:email => params[:email])
      if @state.save
        redirect_to root_path
      end
    else
    end
  end

  def search
    @query = params[:q] || ""
    @search_type = params[:search_type] || "all"
    @search_session = params[:session_id]
    @search_options = {
      :page => params[:page],
      :per_page => 15,
      :order => params[:order]
    }

    if @search_session
      @search_options[:with].merge!(:session_id => @search_session)
    end

    if @query
      case @search_type
        when "all"
          @legislators = Person.search(@query, @search_options)
          @search_options.merge({:with => {:state_id => @state.id}})
          @bills = @state.bills.search(@query, @search_options)
        when "bills"
          @search_options.merge({:with => {:state_id => @state.id}})
          @bills = @state.bills.search(@query, @search_options)
          @total_entries = @bills.total_entries
        when "legislators"
          @legislators = Person.search(@query, @search_options)
          @total_entries = @legislators.total_entries
      end
      render :template => "states/results.html.haml"
    else
      render :nothing => true
    end
  end

  protected

  def get_state
    @state = State.find_by_slug(request.subdomain, :include => {:legislature => {:upper_chamber => :districts, :lower_chamber => :districts}})

    @state || resource_not_found
  end
end
