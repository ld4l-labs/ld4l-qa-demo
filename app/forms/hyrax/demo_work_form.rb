# Generated via
#  `rails generate hyrax:work DemoWork`
module Hyrax
  class DemoWorkForm < Hyrax::Forms::WorkForm
    self.model_class = ::DemoWork
    self.terms += [:resource_type]
  end
end
