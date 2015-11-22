module Api
  module V1
    class GamesController < ApiBaseController

      def index
        render "index"
      end

      def show
        render "show"
      end

      def create
        render "create"
      end

      def edit
        puts "------------> edit"
      end

      def update
        puts "------------> update"
      end

      def destroy
        puts "------------> destroy"
      end
    end
  end
end
