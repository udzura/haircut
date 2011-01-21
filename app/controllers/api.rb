Haircut.controllers :api, :"v.1" do
  before { basic_auth! }
  get :create, :provides => [:xml] do
    @slug = Slug.new(
      :url =>  params[:url],
      :slug => (
        case
        when params[:slug].present?
          params[:slug]
        when params[:prefix].present?
          "#{params[:prefix]}*"
        else
          nil
        end
      )
    )
    if @slug.save
      builder :"api/create"
    else
      throw :halt, [500, builder(:"api/error")]
    end
  end

end
