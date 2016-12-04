# frozen_string_literal: true

# Loads data from Facebook group to database
class SearchEvents
  extend Dry::Monads::Either::Mixin
  extend Dry::Container::Mixin

  register :validate_params, lambda { |params|
    puts params
    query = EventsSearchCriteria.new(params)
    puts query.terms
    if query
      Right(query: query)
    else
      Left(Error.new(:not_found, 'Search terms error'))
    end
  }

  register :search_events, lambda { |input|
    search_terms = input[:query].terms
    events = EventsQuery.call(search_terms)
    results = EventsSearchResults.new(events, search_terms)
    Right(results)
  }

  def self.call(params)
    Dry.Transaction(container: self) do
      step :validate_params
      step :search_events
    end.call(params)
  end
end
