module DisponibiliteValidations

  # Checks that reservation start date is before end dates
  def date_debut_avant_date_fin
    return unless date_heure_debut && date_heure_fin
    if date_heure_fin < date_heure_debut
      errors.add(:base, "La date heure de début de la disponibilité doit être avant la date heure de fin.\n")
    end
  end

  # Checks that the equipment model is available from start date to due date
  def disponible
    # do not run on disponibilite that don't matter anymore
    return unless utilisateur_remplacant_id && date_heure_debut && date_heure_fin
    return if self.statut == "attribue" || date_heure_fin < DateTime.now
    if Disponibilite.where("utilisateur_remplacant_id = :utilisateur_remplacant_id and id != :disponibilite_id and (:date_heure_debut between date_heure_debut " +
                           "and date_heure_fin OR :date_heure_fin between date_heure_debut and date_heure_fin)",
                           {utilisateur_remplacant_id: utilisateur_remplacant_id, disponibilite_id: id, date_heure_debut: date_heure_debut,
                            date_heure_fin: date_heure_fin}).any?
      errors.add(:base, "L'utilisateur remplaçant a déjà un remplacement dans ces heures.\n")
    end
  end

  # Checks that reservation is not in the past
  # Does not run on checked out, checked in, overdue, or missed Reservations
  def dates_non_passees
    return unless date_heure_debut && date_heure_fin
    if date_heure_fin < DateTime.now || date_heure_debut < DateTime.now
      errors.add(:base, "Les dates de début et de fin ne peuvent pas être dans le passé.\n")
    end
  end
end