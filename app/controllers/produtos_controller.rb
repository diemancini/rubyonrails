class ProdutosController < ApplicationController

	def index
		@produtos_por_nome = Produto.order(:nome).limit 5
		@produtos_por_preco = Produto.order(:preco).limit 2
	end

	def create
		dados = params.require(:produto).permit :nome, :preco, :descricao, :quantidade
		# Esse código abaixo grava no bd, mas retorna erro detalhado, caso não consiga salvar
		#produto = Produto.create dados
		# Já esse retorna apenas true/false para o gravamento do bd.
		@produto = Produto.new dados
		if @produto.save
			redirect_to root_url
		else
			#renderiza o new.html.erb
			render :new
		end
	end

	def busca
		@nome = params[:nome]
		@produtos = Produto.where "nome like ?", "%#{@nome}%"
	end

	def destroy
		id = params[:id]
		Produto.destroy id
		redirect_to root_url
	end
end
