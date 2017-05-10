require 'hanami/helpers/form_helper/form_builder.rb'

# モンキーパッチ
module Hanami
  module Helpers
    module FormHelper
      class FormBuilder
        def error_field(name, attributes = {}, &blk)
          return if params.valid?

          errors = params.errors[@name][name]
          return unless errors

          attrs = {class: 'error-field'}.merge(attributes)

          div errors.join(', '), attrs, &blk
        end
      end
    end
  end
end
