# module ActiveRecord
#   class Base
#     attr_accessor :saved
#     alias_method :saved?, :saved
#     after_save :mark_saved

#     private
#     def mark_saved
#       @saved = true
#     end
#   end
# end