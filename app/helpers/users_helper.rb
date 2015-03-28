module UsersHelper
  LISTE_POSTE = {'Professeur permanent' => 'permanent', 'Professeur remplaçant' => 'remplacant'}
  LISTE_NIVEAU = {'Maternelle' => 1,'1ère année' => 2,'2e année' => 3,'3e année' => 4,'4e année' => 5,'5e année' => 6,'6e année' => 7}


  def get_description_poste(id)
    if !id.nil? and LISTE_POSTE.has_value?(id) then
      return LISTE_POSTE.key(id)
    else
      return ""
    end
  end

  def get_description_niveau(id)
    if !id.nil? and LISTE_NIVEAU.has_value?(id) then
      return LISTE_NIVEAU.key(id)
    else
      return ""
    end
  end
end
