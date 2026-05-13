# frozen_string_literal: true

module SerializerHandler
  def serialize(collection, serializer, root:, meta: nil)
    ActiveModelSerializers::SerializableResource.new(collection,
                                                     each_serializer: serializer,
                                                     adapter: :json,
                                                     root: root,
                                                     meta: meta)
                                                .as_json
  end
end
