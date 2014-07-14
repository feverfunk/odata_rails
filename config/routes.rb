Api::Application.routes.draw do

  controller :o_data do
    # scope 'OData.svc', as: :o_data, defaults: { format: :xml } do
    scope 'OData.svc', as: :o_data do
      get '/', to: :index
      get '/:odata_param', to: :odata_query
    end
  end

 

end
