module DisponibilitesConcern
  extend ActiveSupport::Concern

  def date_heure_limit_answer(disponibilite)
    return (disponibilite.created_at + 3.hours).strftime("%Y/%m/%d %l:%M %p") if disponibilite and disponibilite.created_at
  end

  def get_disponibilites(date_heure_debut = Date.current, date_heure_fin = Date.current + 2.months)
    if current_user.role? :admin or current_user.role? :super_admin then
      liste_disponibilites = Disponibilite.by_statut_waiting_available.by_between_date_debut_fin(date_heure_debut, date_heure_fin)
    elsif current_user.role? :permanent then
      liste_disponibilites = Disponibilite.by_statut_waiting_available.by_between_date_debut_fin(date_heure_debut, date_heure_fin).by_user_absent(current_user.id)
    elsif current_user.role? :remplacant then
      liste_disponibilites = Disponibilite.by_statut_waiting_available.by_between_date_debut_fin(date_heure_debut, date_heure_fin).by_user_remplacant(current_user.id)
    end

    return liste_disponibilites
  end

  def get_disponibilites_avenir_non_attribue(date_heure_debut = Date.current, date_heure_fin = Date.current + 2.months)
    liste_disponibilites = get_disponibilites(date_heure_debut, date_heure_fin)

    if liste_disponibilites.nil? then
      return liste_disponibilites
    else
      return liste_disponibilites.order("date_heure_debut").first(10)
    end
  end

end