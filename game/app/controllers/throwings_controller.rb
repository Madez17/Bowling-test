class ThrowingsController < ApplicationController
    def index
      @throwings = Throwing.all()
    end

    def new
      @throwing = Throwing.new
    end

    def create
      @throwing = Throwing.new(throwing_params)
      @throwing.calculate_score()

      # Verificaremos si la entrada se guardo
      if @throwing.save
        redirect_to @throwing
      else
	render 'new'
      end
    end

    def show
       @throwing = Throwing.find(params[:id])
    end

    private

    def throwing_params
      params.require(:throwing).permit(:entrada)
    end
end
