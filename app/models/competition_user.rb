require 'csv'

class CompetitionUser < ActiveRecord::Base
  belongs_to :competition
  belongs_to :user

  attr_accessor :competition, :user

  mount_uploader :predicfile, PredictionUploader


  def computeScore (idcomp, iduser)

    comp = Competition.where(id: idcomp).first
    cuser = CompetitionUser.where(competition_id: idcomp, user_id: iduser).first

    regs1 = []
    regs2 = []

    n = 0.0
    a = 0

    CSV.foreach(comp.testdata.path, headers: true) do |row|
      regs1 << (row['Letter'].to_s)
    end

    CSV.foreach(cuser.predicfile.path, headers: true) do |row|
      regs2 << (row['Letter'].to_s)
    end

    for i in 0..9
      if regs1[i] == regs2[i]
        a = a+1
      end
    end

    n = (a.to_f/10).to_f

    cuser.score = n
    cuser.save

  end

  def have_score
    x = false
    if score != nil
      x = true
    end
    return x
  end

end
