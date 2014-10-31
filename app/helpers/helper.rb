helpers do
  def h_(text)
    Rack::Utils.escape(text)
  end
end
