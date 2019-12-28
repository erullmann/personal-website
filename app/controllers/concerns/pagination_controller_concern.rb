require 'active_support/concern'

module PaginationControllerConcern
  extend ActiveSupport::Concern

  included do
    def paginate(scope)
      set_page_variables(scope)
      scope.page(@current_page)
    end

    def total_pages
      (count / self.class.page_size_value).ceil
    end
  end

  private

  def set_page_variables(scope)
    @total_pages = scope.total_pages
    @current_page = get_page

    if @current_page <= 1
      @previous_page = nil
      @first_page = nil
    else
      @previous_page = @current_page - 1

      if @current_page > 2
        @first_page = 1
      else
        @first_page = nil
      end
    end
    if @current_page >= @total_pages
      @next_page = nil
      @last_page = nil
    else
      @next_page = @current_page + 1

      if @current_page < @total_pages - 1
        @last_page = @total_pages
      else
        @last_page = nil
      end
    end
  end

  def get_page
    if params[:page]
      begin
        params[:page].to_i
      rescue Exception => e
        0
      end
    else
      0
    end
  end
end