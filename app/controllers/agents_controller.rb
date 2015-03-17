class AgentsController < UserApplicationController
  def index
    @agents = @user.agents_with_extra_data
  end
  def new
    @agent = Agent.new
  end
  def create
    @user.accepts_new_agents?.if true: ->{ create_new_agent }, false: ->{ cant_create }
  end
  def show
    @agent = @user.agents.find(params[:id])
    @listings = @agent.listings.select(Listing.default_select)
  end
  def edit
    @agent = @user.agents.find(params[:id])
  end
  def update
    @agent = @user.agents.find(params[:id])
    @agent.update(agent_params).if true: ->{
      redirect_to agents_path
    },
    false: ->{
      render :edit
    }
  end
  def destroy
    @agent = @user.agents.find(params[:id])
    @agent.delete
    redirect_to agents_path
  end
  private
  def create_new_agent
    @agent = @user.agents.create agent_params
    @agent.saved?.if true: ->{
      redirect_to agents_path
    },
    false: ->{
      cant_create
    }
  end
  def cant_create
    render :new    
  end
  def agent_params
    params.require(:agent).permit(:terms, :location_id, :auto_send_resume, :email_updates, :whitelist, :blacklist)
  end
end