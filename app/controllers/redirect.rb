Haircut.controllers :redirect do
  get :redirect, :map => "/:slug" do
    slug = Slug.find_by_slug!(params[:slug])
    slug.accesses.create(:referer => request.referer)
    redirect slug.url
  end
end
