# encoding: utf-8
Haircut.controllers :admin do
  before { basic_auth! }
  
  layout :admin
  get :new, :map => "/" do
    @slug = Slug.new
    erb :"admin/new"
  end

  get :show, :map => "/info/:slug(/:page)" do
    @slug = Slug.find_by_slug!(params[:slug])
    @accesses = @slug.accesses.paginate(:page => (params[:page].presence || 1), :per_page => 10)
    erb :"admin/show"
  end

  post :create, :map => "/" do
    @slug = Slug.new(params[:slug])
    if @slug.save
      flash[:notice] = t("haircut.admin.created", :url => @slug.url)
      redirect url_for(:admin, :new)
    else
      @slug.slug = params[:slug][:slug]
      erb :"admin/new"
    end
  end

  get :list, :map => "/list(/:page)" do
    @slugs = Slug.paginate(:page => (params[:page].presence || 1), :per_page => 10)
    erb :"admin/list"
  end

  delete :destroy, :map => ":slug" do
    @slug = Slug.find_by_slug!(params[:slug])
    if @slug.destroy
      flash[:notice] = t("haircut.admin.destroyed", :url => @slug.url)
      redirect url_for(:admin, :list)
    else
      flash[:notice] = t("haircut.admin.destroy_failed", :url => @slug.url)
      erb :"admin/show"
    end
  end
end
