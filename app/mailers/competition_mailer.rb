class CompetitionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.competition_mailer.update_competition.subject
  #

  #Lógica para enviar emails de actualización de competición
  def self.send_update_competition_email(users,competition)
    users.each do |user|
      update_competition(user, competition).deliver_now
    end
  end

  def update_competition(user,competition)
    @user = user
    @competition = competition
    mail( :to => @user.email, :subject => "Start Competition") do |format|
      format.html
    end
  end

  #Lógica para enviar emails de inicio de competición (fase regular o primera fase)

  def self.send_start_competition(users, competition)
    users.each do |user|
      startCompetition(user, competition).deliver_now
    end
  end

  def startCompetition(user,competition)
    @user = user
    @competition = competition
    mail( :to => @user.email, :subject => "Start Competition") do |format|
      format.html
    end
  end

  #Lógica para enviar emails de inicio de competición (fase avanzada)
  def self.send_start_competition_plaoff(users, competition)
    users.each do |user|
      startCompetitionPlaoff(user, competition).deliver_now
    end
  end

  def startCompetitionPlaoff(user,competition)
    @user = user
    @competition = competition
    mail( :to => @user.email, :subject => "Start Competition (Next Round)") do |format|
      format.html
    end
  end

  #Lógica para enviar emails de fin de competición
  def self.send_end_competition(users, competition)
    users.each do |user|
      endCompetition(user, competition).deliver_now
    end
  end

  def endCompetition(user,competition)
    @user = user
    @competition = competition
    mail( :to => @user.email, :subject => "End Competition") do |format|
      format.html
    end
  end

end
