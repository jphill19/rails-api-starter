class TeaSerializer
  include JSONAPI::Serializer

  attributes :title, :description, :price
end
