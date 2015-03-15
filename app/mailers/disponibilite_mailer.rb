class DisponibiliteMailer < ApplicationMailer
  default from: "nickdemers@gmail.com"

  def nouvelle_disponibilite_email(utilisateur, disponibilite)
    @utilisateur = utilisateur
    @url  = "http://localhost:3000/disponibilites/" + disponibilite.id.to_s
    #todo remettre --> to: @utilisateur.email
    mail(to: "nickdemers@gmail.com", subject: 'Nouvelle disponibilité')
  end

end
