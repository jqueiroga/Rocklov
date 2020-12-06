require_relative "base_service"

class EquipoService < BaseService
  def create(equipe, user_id)
    payload = equipe

    self.class.post(
      "/equipos",
      body: payload,
      headers: {
        "user_id": user_id,
      },
    )
  end
end
