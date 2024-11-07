# frozen_string_literal: true

module ResponseHandler
  def render_error(error, status)
    render json: {
      "success": false,
      "errors": error
    }, status:
  end

  def render_ok(data = [])
    render json: {
      "success": true,
      "results": data
    }, status: :ok
  end
end
