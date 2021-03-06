# -*- encoding: utf-8 -*-
module PagSeguro
  class PaymentMethod
    include Extensions::MassAssignment

    TYPES = {
      "1" => :credit_card,
      "2" => :bank_slip,
      "3" => :tef,
      "4" => :pagseguro,
      "5" => :paggo
    }.freeze

    # The payment method code.
    attr_accessor :code

    # The payment method type.
    attr_accessor :type_id

    # Define shortcuts dynamically.
    TYPES.each do |id, type|
      define_method "#{type}?" do
        type_id.to_s == id
      end
    end

    # Return the type in a readable manner.
    def type
      TYPES.fetch(type_id.to_s) { raise "PagSeguro::PaymentMethod#type_id isn't mapped" }
    end

    # Return the payment method's description.
    def description
      I18n.t(code, scope: "pagseguro.payment_methods")
    end
  end
end
