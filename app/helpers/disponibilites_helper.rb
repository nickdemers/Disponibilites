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
      return format_date_heure(@disponibilite.date_heure_debut) + " - " + format_date_heure(@disponibilite.date_heure_fin)
    else
      return ""
    end
  end

  def get_date_heure_debut_format
    if @disponibilite.nil? or @disponibilite.date_heure_debut.nil? then
      date_time = DateTime.now + 1.day
      return format_date_heure(date_time.change(hour: 7, min: 30))
    else
      return format_date_heure(@disponibilite.date_heure_debut)
    end
  end

  def get_date_heure_fin_format
    if @disponibilite.nil? or @disponibilite.date_heure_fin.nil? then
      date_time = DateTime.now + 1.day
      return format_date_heure(date_time.change(hour: 16, min: 30))
    else
      return format_date_heure(@disponibilite.date_heure_fin)
    end
  end

  def format_date_heure(date_heure)
    if date_heure
      return date_heure.strftime("%Y/%m/%d %l:%M %p")
    else
      return ""
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

  def disponibilite_statut_css(statut)
    if statut.eql?("assigned")
      "success"
    elsif statut.eql?("waiting")
      "warning"
    else
      "danger"
    end
  end

  def is_time_expired?(date_time)
    if (date_time + 3.hours) < Time.current
      return true
    else
      return false
    end
  end
end
