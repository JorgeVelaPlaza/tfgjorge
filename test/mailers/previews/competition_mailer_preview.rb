# Preview all emails at http://localhost:3000/rails/mailers/competition_mailer
class CompetitionMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/competition_mailer/update_competition
  def update_competition
    CompetitionMailer.update_competition
  end

end
