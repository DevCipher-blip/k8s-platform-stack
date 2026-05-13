# frozen_string_literal: true

# Wraps an index relation with optional filtering (subclasses override
# filter_records) and page/per_page pagination in a stable id order.
class BaseCollection
  DEFAULT_PER_PAGE = 25
  MAX_PER_PAGE = 100

  attr_reader :params

  def initialize(relation, params)
    @relation = relation
    @params = params
  end

  def results
    @results ||= filtered.reorder(:id).limit(per_page).offset((page - 1) * per_page)
  end

  def meta
    { page: page, per_page: per_page, total_count: total_count, total_pages: (total_count.to_f / per_page).ceil }
  end

  private

    def filtered
      @filtered ||= begin
        filter_records

        @relation
      end
    end

    def total_count
      @total_count ||= filtered.except(:includes, :preload, :eager_load).count
    end

    def page
      [params[:page].to_i, 1].max
    end

    def per_page
      requested = params[:per_page].to_i
      requested.positive? ? [requested, MAX_PER_PAGE].min : DEFAULT_PER_PAGE
    end

    def filter
      @relation = yield
    end

    def filter_records; end
end
