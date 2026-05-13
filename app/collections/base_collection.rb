# frozen_string_literal: true

class BaseCollection
  attr_reader :params

  def initialize(relation, params)
    @relation = relation
    @params = params
  end

  def results
    @results ||= begin
      filter_records

      @relation
    end
  end

  private

    def filter
      @relation = yield
    end

    def filter_records; end
end
