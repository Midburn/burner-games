RSpec.shared_context "api common" do
  let(:session) { create :session }
  let(:session_param) { { session: session.token } }
end

RSpec.shared_context "api action" do
  # Parameters
  let(:parameters) { {} }
  let(:parameters_not_found) { {} }
  let(:parameters_invalid) { {} }
  let(:parameters_paginated) { { limit: 1, offset: 1 } }

  # Actions
  let(:action) { api_call type, route, parameters }
  let(:action_not_found) { api_call type, route, session_param.merge(parameters_not_found) }
  let(:action_not_authorized) { api_call type, route, session_param.merge(parameters_not_authorized) }
  let(:action_invalid) { api_call type, route, session_param.merge(parameters_invalid) }
  let(:action_success) { api_call type, route, session_param.merge(parameters) }
  let(:action_success_paginated) { api_call type, route, session_param.merge(parameters_paginated) }
  let(:action_success_different) { api_call type, route, session_param.merge(parameters_different) }
end

