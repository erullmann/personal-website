class ApplicationController < ActionController::Base
  include OffsetConcern
  include PaginationControllerConcern
end
