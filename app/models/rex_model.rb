class RexModel < ActiveRecord::Base
  self.abstract_class = true
  attr_accessor :saved
  # alias_method :saved?, :saved
  after_save :mark_saved
  def saved?
    @saved
  end
  private
  def mark_saved
    @saved = true
  end
end
