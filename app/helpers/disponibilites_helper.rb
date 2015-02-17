module DisponibilitesHelper

  LISTE_ECOLE = {'École 1' => 1,'École 2' => 2, 'École 3' => 3,'École 4'=> 4}
  LISTE_STATUT = {'Disponible' => 'disponible','Attente' => 'attente','Attribué' => 'attribue'}

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

  def get_utilisateur_remplacant_nom_format
    if @utilisateur_remplacant.nil? or @utilisateur_remplacant.nom.nil? or @utilisateur_remplacant.prenom.nil? then
      return ""
    else
      return @utilisateur_remplacant.nom + ', ' + @utilisateur_remplacant.prenom
    end
  end

  def get_disponibilites_avenir_non_attribue(date_heure_debut = Date.current, date_heure_fin = Date.current + 2.months)
    if current_utilisateur.role? :admin then
      liste_disponibilites = Disponibilite.where("(statut = 'attente' or statut = 'disponible') and date_heure_debut between :date_debut and :date_fin", {date_debut: date_heure_debut, date_fin: date_heure_fin})
    elsif current_utilisateur.role? :permanent then
      liste_disponibilites = Disponibilite.where("(statut = 'attente' or statut = 'disponible') and date_heure_debut between :date_debut and :date_fin and utilisateur_absent_id = :utilisateur_absent_id", {date_debut: date_heure_debut, date_fin: date_heure_fin, utilisateur_absent_id: current_utilisateur.id})
    elsif current_utilisateur.role? :remplacant then
      liste_disponibilites = Disponibilite.where("(statut = 'attente' or statut = 'disponible') and date_heure_debut between :date_debut and :date_fin and utilisateur_remplacant_id = :utilisateur_remplacant_id", {date_debut: date_heure_debut, date_fin: date_heure_fin, utilisateur_remplacant_id: current_utilisateur.id})
    end
    if !liste_disponibilites.nil? then
      return liste_disponibilites.order("date_heure_debut").first(10)
    else
      return liste_disponibilites
    end
  end

  def get_disponibilites(date_heure_debut = Date.current, date_heure_fin = Date.current + 2.months)
    if current_utilisateur.role? :admin then
      liste_disponibilites = Disponibilite.where("date_heure_debut between :date_debut and :date_fin", {date_debut: date_heure_debut, date_fin: date_heure_fin})
    elsif current_utilisateur.role? :permanent then
      liste_disponibilites = Disponibilite.where("date_heure_debut between :date_debut and :date_fin and utilisateur_absent_id = :utilisateur_absent_id", {date_debut: date_heure_debut, date_fin: date_heure_fin, utilisateur_absent_id: current_utilisateur.id})
    elsif current_utilisateur.role? :remplacant then
      liste_disponibilites = Disponibilite.where("date_heure_debut between :date_debut and :date_fin and utilisateur_remplacant_id = :utilisateur_remplacant_id", {date_debut: date_heure_debut, date_fin: date_heure_fin, utilisateur_remplacant_id: current_utilisateur.id})
    end

    return liste_disponibilites

  end
end
