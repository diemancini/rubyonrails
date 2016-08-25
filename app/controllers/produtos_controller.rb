class ProdutosController < ApplicationController

	# Quando as actions do vetor abaixo forem chamadas, o primeiro 
	# método a ser executado será o set_product.
	before_action :set_product, only: [:edit, :update, :destroy]

	def index
		@produtos_por_nome = Produto.order(:nome).limit 15
		@produtos_por_preco = Produto.order(:preco).limit 5
	end

	def new
		@produto = Produto.new
		#@departamentos = Departamento.all
		render_view :new
	end

	def edit
		render_view :edit
	end

	def update
		#dados = params.require(:produto).permit :nome, :preco, :descricao, :quantidade, :departamento_id
		if @produto.update product_params_values
			flash[:notice] = "Produto atualizado com sucesso"
			redirect_to root_url
		else
			render_view :edit
		end
	end

	def create
		#dados = params.require(:produto).permit :nome, :preco, :descricao, :quantidade, :departamento_id
		# Esse código abaixo grava no bd, mas retorna erro detalhado, caso não consiga salvar
		#produto = Produto.create dados
		# Já esse retorna apenas true/false para o gravamento do bd.
		@produto = Produto.new product_params_values
		if @produto.save
			flash[:notice] = "Produto salvo com sucesso!"
			redirect_to root_url
		else
			#renderiza o new.html.erb
			render_view :new
		end
	end

	def busca
		@nome = params[:nome]
		@produtos = Produto.where "nome like ?", "%#{@nome}%"
	end

	def destroy
		@produto.destroy
		redirect_to root_url
	end

	private

	def render_view(view)
		@departamentos = Departamento.all
		render view
	end

	def set_product
		id = params[:id]
		@produto = Produto.find(id)
	end

	def product_params_values
		dados = params.require(:produto).permit :nome, :preco, :descricao, :quantidade, :departamento_id
	end
end
