module DisponibilitesHelper

  LISTE_ECOLE = {'École 1' => 1,'École 2' => 2, 'École 3' => 3,'École 4'=> 4}
  LISTE_STATUT = {'Disponible' => 'available', 'Attente' => 'waiting', 'Attribué' => 'assigned', 'Refusé' => 'denied', 'Annulé' => 'canceled'}

  def get_description_ecole(id)
    if !id.nil? and LISTE_ECOLE.has_value?(id) then
      return LISTE_ECOLE.key(id)
    else
      return ""
    end
  end

  def get_description_statut(id)
    if !id.nil? and LISTE_STATUT.has_value?(id) then
      return LISTE_STATUT.key(id)
    else
      return ""
    end
  end

  def get_date_heure_format
    if !@disponibilite.nil? and !@disponibilite.date_heure_debut.nil? and !@disponibilite.date_heure_fin.nil?
      return @disponibilite.date_heure_debut.strftime("%Y/%m/%d %l:%M %p") + " - " + @disponibilite.date_heure_fin.strftime("%Y/%m/%d %l:%M %p")
    else
      return ""
    end
  end

  def get_date_heure_debut_format
    if @disponibilite.nil? or @disponibilite.date_heure_debut.nil? then
      return DateTime.now.strftime("%Y/%m/%d %l:%M %p")
    else
      return @disponibilite.date_heure_debut.strftime("%Y/%m/%d %l:%M %p")
    end
  end

  def get_date_heure_fin_format
    if @disponibilite.nil? or @disponibilite.date_heure_fin.nil? then
      return DateTime.now.strftime("%Y/%m/%d %l:%M %p")
    else
      return @disponibilite.date_heure_fin.strftime("%Y/%m/%d %l:%M %p")
    end
  end

  def get_user_absent_nom_format(disponibilite)
    if disponibilite.user_absent.nil? or disponibilite.user_absent.nom.nil? or disponibilite.user_absent.prenom.nil? then
      return ""
    else
      return disponibilite.user_absent.nom + ', ' + disponibilite.user_absent.prenom
    end
  end

  def get_user_remplacant_nom_format(disponibilite)
    if disponibilite.user_remplacant.nil? or disponibilite.user_remplacant.nom.nil? or disponibilite.user_remplacant.prenom.nil? then
      return ""
    else
      return disponibilite.user_remplacant.nom + ', ' + disponibilite.user_remplacant.prenom
    end
  end

  def get_disponibilites_avenir_non_attribue(date_heure_debut = Date.current, date_heure_fin = Date.current + 2.months)
    if current_user.role? :admin or current_user.role? :super_admin then
      liste_disponibilites = Disponibilite.where("(statut = 'waiting' or statut = 'available') and date_heure_debut between :date_debut and :date_fin", {date_debut: date_heure_debut, date_fin: date_heure_fin})
    elsif current_user.role? :permanent then
      liste_disponibilites = Disponibilite.where("(statut = 'waiting' or statut = 'available') and date_heure_debut between :date_debut and :date_fin and user_absent_id = :user_absent_id", {date_debut: date_heure_debut, date_fin: date_heure_fin, user_absent_id: current_user.id})
    elsif current_user.role? :remplacant then
      liste_disponibilites = Disponibilite.where("(statut = 'waiting' or statut = 'available') and date_heure_debut between :date_debut and :date_fin and user_remplacant_id = :user_remplacant_id", {date_debut: date_heure_debut, date_fin: date_heure_fin, user_remplacant_id: current_user.id})
    end
    if !liste_disponibilites.nil? then
      return liste_disponibilites.order("date_heure_debut").first(10)
    else
      return liste_disponibilites
    end
  end

  def get_disponibilites(date_heure_debut = Date.current, date_heure_fin = Date.current + 2.months)
    if current_user.role? :admin or current_user.role? :super_admin then
      liste_disponibilites = Disponibilite.where("date_heure_debut between :date_debut and :date_fin", {date_debut: date_heure_debut, date_fin: date_heure_fin})
    elsif current_user.role? :permanent then
      liste_disponibilites = Disponibilite.where("date_heure_debut between :date_debut and :date_fin and user_absent_id = :user_absent_id", {date_debut: date_heure_debut, date_fin: date_heure_fin, user_absent_id: current_user.id})
    elsif current_user.role? :remplacant then
      liste_disponibilites = Disponibilite.where("date_heure_debut between :date_debut and :date_fin and user_remplacant_id = :user_remplacant_id", {date_debut: date_heure_debut, date_fin: date_heure_fin, user_remplacant_id: current_user.id})
    end

    return liste_disponibilites

  end
end
