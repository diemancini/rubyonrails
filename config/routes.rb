Rails.application.routes.draw do
    # resources cria todas as rotas automaticamente
    resources :produtos, only: [:new, :create, :destroy]
    get "produtos/busca" => "produtos#busca", as: :busca_produto

    #get "/produtos/new" => "produtos#new"
    #delete "/produtos/:id" => "produtos#destroy", as: :produto
    #post "/produtos" => "produtos#create"
    #get "produtos" => "produtos#index"
    root "produtos#index" #redireciona a rota /produtos para a "home".
end
