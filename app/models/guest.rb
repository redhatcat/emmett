class Guest < Hobo::Model::Guest # :nodoc:

  def administrator?
    false
  end

end
