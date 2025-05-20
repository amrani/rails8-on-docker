class WorkflowsController < ApplicationController
  def index
    user_uuid = "some_unique_identifier"

    # How often and when you update your user's data depends on your setup.
    # security note: We have multiple layers of encryption for user data and our encryption keys are routinely rotated.
    EmbedWorkflow::Users.upsert(
      key: user_uuid,
      name: "Any name you want",
      data: { user_api_token: "ABC-1234" }
    )

    current_time = Time.now.to_i
    @jwt_token   = JWT.encode({
      sub: user_uuid,
      iat: current_time,
      exp: current_time + (60 * 60),
      discover: true
    }, ENV["EMBED_WORKFLOW_SK_LIVE"], "HS256").to_s
  end
end
