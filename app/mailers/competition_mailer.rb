class CompetitionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.competition_mailer.update_competition.subject
  #
  def update_competition(id_comp)
    #i = 1
    @competition = Competition.find(id_comp)
    CompetitionUser.all.each do |i|
      @cu = CompetitionUser.find(i)
      if @cu.competition_id == id_comp
        @user = User.find(@cu.user_id)
        mail( :to => @user.email, :subject => "Actualización de competición") do |format|
            format.html
        end
      end
    end
  end
end
