defmodule ApiDeBlogsWeb.Guardian do
  use Guardian, otp_app: :api_de_blogs

  def subject_for_token(resource, _claims) do
    sub = to_string(resource)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do
    resource = ApiDeBlogs.get_user(claims)
    {:ok, resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
