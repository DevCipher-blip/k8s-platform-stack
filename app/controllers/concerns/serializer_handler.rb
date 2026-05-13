# frozen_string_literal: true

module SerializerHandler
  def serialize(collection, serializer, record = nil)
    return {} unless collection

    ActiveModelSerializers::SerializableResource.new(collection,
                                                     each_serializer: serializer,
                                                     adapter: :json,
                                                     data: record)
                                                .as_json
  end
end
