class String
  def can_be_integer?
    (0..9).map(&:to_s).include? self[0]
  end
end
