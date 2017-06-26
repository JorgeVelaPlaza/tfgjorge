require 'csv'

class CompetitionUser < ActiveRecord::Base
  belongs_to :competition
  belongs_to :user

  attr_accessor :competition, :user

  mount_uploader :predicfile, PredictionUploader


  def computeScore(idcomp, iduser)
    comp = Competition.where(id: idcomp).first
    com_user = CompetitionUser.where(competition_id: idcomp, user_id: iduser).first

    regsTest = []
    regsPred = []
    regsRes = []
    regsVars = []


    scorePred = 0.0
    a = 0.0
    same = 0

    case comp.metric
      when 'Mean Absolute Error'
        read_CSV_regresion(comp.testdata.path, regsTest, com_user.predicfile.path,
         regsPred)
        n = regsPred.size-1
        for i in 0..n
          regsRes[i] = ((regsTest[i] - regsPred[i]).abs).to_d
        end
        scorePred = regsRes.instance_eval { reduce(:+) / size.to_d }

      when 'Root Mean Squared Error'
        read_CSV_regresion(comp.testdata.path, regsTest, com_user.predicfile.path,
         regsPred)
        n = regsPred.size-1
        for i in 0..n
          a += ((regsTest[i] - regsPred[i])**2).to_d
        end
        scorePred =  Math.sqrt(a)/regsPred.size

      when 'Weighted Mean Absolute Error'
        regsWeight = []
        read_CSV_weightedMAE(comp.testdata.path, regsTest, regsWeight,
          com_user.predicfile.path, regsPred)
        n = regsPred.size-1
        for i in 0..n
          regsRes[i] = (regsWeight[i]*(regsTest[i] - regsPred[i])).to_d
        end
        scorePred = regsRes.instance_eval { reduce(:+) / size.to_d }

      when 'Accuracy'
        read_CSV_clasification(comp.testdata.path, regsTest, com_user.predicfile.path, regsPred)

        checkNumberCase(regsTest, regsVars)
        n = regsPred.size-1
        for i in 0..n
          if regsTest[i] == regsPred[i]
            same += 1
            puts same
          end
        end
        scorePred = same/(n+1).to_f

      when 'Mean Utility'
        wtp = 0.75
        wtn = 0.25
        wfp = -0.75
        wfn = -0.25
        tp = 0
        tn = 0
        fp = 0
        fn = 0

        read_CSV_clasification(comp.testdata.path, regsTest, com_user.predicfile.path,
         regsPred)

        n = regsPred.size-1

        for i in 0..n
          if regsPred[i] == 1
            if regsTest[i] == 1
              tp += 1
            else
              fn += 1
            end
          else
            if regsTest[i] == 0
              tn += 1
            else
              fp += 1
            end
          end
        end
        scorePred = (wtp*tp)+(wtn*tn)+(wfp*fp)+(wfn*fn)

    end#case
    com_user.score = scorePred.round(4)
    com_user.save
  end #method computerScore

  def have_score
    x = false
    if score != nil
      x = true
    end
    return x
  end

  private

  def read_CSV_regresion(csv_file_1, arrTest, csv_file_2, arrPred)
    CSV.foreach(csv_file_1, headers: true) do |row|
      arrTest << (row['Predic'].to_f)
    end

    CSV.foreach(csv_file_2, headers: true) do |row|
      arrPred << (row['Predic'].to_f)
    end
  end

  def read_CSV_weightedMAE(csv_file_1, arrTest, arrWeight, csv_file_2, arrPred)
    CSV.foreach(csv_file_1, headers: true) do |row|
      arrTest << (row['Predic'].to_f)
    end

    CSV.foreach(csv_file_1, headers: true) do |row|
      arrWeight << (row['Weight'].to_f)
    end

    CSV.foreach(csv_file_2, headers: true) do |row|
      arrPred << (row['Predic'].to_f)
    end
  end

  def read_CSV_clasification(csv_file_1, arrTest, csv_file_2, arrPred)
    CSV.foreach(csv_file_1, headers: true) do |row|
      arrTest << (row['Predic'].to_s)
    end

    CSV.foreach(csv_file_2, headers: true) do |row|
      arrPred << (row['Predic'].to_s)
    end
  end



  def checkNumberCase(arrayT, arrayV)
    n = arrayT.size-1
    for i in 0..n
      if i == 0
        arrayV[i] = arrayT[i]
        puts arrayV[i]
      else
        element = arrayT[i]
        includ = true
        m = arrayV.size-1
        for j in 0..m
          if element == arrayV[j]
            includ = false
            break
          end
        end
        if includ == true
          arrayV.push(element)
          puts element
        end #if
      end #if
    end #for
  end #method

end #class

