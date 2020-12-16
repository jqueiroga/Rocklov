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

  def bookings(equipo_id, user_locator_id)
    return self.class.post(
             "/equipos/#{equipo_id}/bookings",
             body: { date: Time.now.strftime("%d/%m/%Y") }.to_json,
             headers: {
               "content-type": "application/json",
               "user_id": user_locator_id,
             },
           )
  end
end
