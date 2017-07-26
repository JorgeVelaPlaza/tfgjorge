class Competition < ActiveRecord::Base
  attr_accessor :name
  has_many :competition_users
  has_many :users, through: :competition_users
  has_many :topics

  validates :titulo, presence: true, length: { minimum: 3, maximum: 100}
  validates :descripcion, presence: true
  validates :premio, presence: true
  validates :dificultad, inclusion: { in: ["Easy", "Medium", "Expert"] }
  validates :dificultad, presence: true
  validates :deadline, presence: true
  validates :metric, inclusion: {in: ["Mean Absolute Error","Root Mean Squared Error",
    "Weighted Mean Absolute Error","Accuracy","Mean Utility"] }
  validates :trainingdata, presence: true
  validates :testdata, presence: true
  validates :type_competition, inclusion: {in: ["regression","classification"] }
  validates :nGroups, presence: true
  validates :nWinners, presence: true


  mount_uploader :trainingdata, TrainingdataUploader
  mount_uploader :testdata, TestdataUploader


  def finish_competition
    self.finished = true
    self.save
    CompetitionMailer.send_end_competition(self.users, self)
  end

  def start_competition_regular
    self.started = true
    self.save
    CompetitionMailer.send_start_competition(self.users, self)
  end

  def start_competition_playoff
    self.started = true
    self.save
    CompetitionMailer.send_start_competition_plaoff(self.users, self)
  end

  def import_winners
    #lista de inscripciones de la competición a importar sus ganadores
    listEnrolls = CompetitionUser.where(competition_id: self.idCompImportWinners).order(score: :desc)

    #Objeto competición para saber el nº de ganadores que tenía la competición
    #de la cual estamos importándolos

    @competitionToImport = Competition.find(self.idCompImportWinners)

    #lista de inscripciones resultante, con los ganadores importados ya inscritos
    listEnrollsWinners = []

    #Sacar los ganadores de la competición a importar y inscribirlos en la que se está creando
    for i in 1..@competitionToImport.nWinners
      userId = listEnrolls[i-1].user_id
      enrollUser = CompetitionUser.new(competition_id: self.id, user_id: userId)
      listEnrollsWinners.push(enrollUser)
      enrollUser.save
    end

    self.distribute_winners_in_groups(listEnrollsWinners)
    self.start_competition_playoff
  end

  def distribute_winners_in_groups(list)
    #Distinguir entre si el numero de grupos es igual o mayor que uno
    #Si es igual a 1 puede significar que será la'fase final de un conjunto
    #de competiciones
    if self.nGroups <= 1
      for i in 0..list.size-1
        list[i].group == 1
        list[i].save
      end
    else
      listNumbers = []
      nUsers_group = list.size/self.nGroups
      for i in 1..self.nGroups
        for j in 1..nUsers_group
          n = Random.new.rand(0..list.size-1)
          puts n
          while listNumbers.include? n do
            n = Random.new.rand(0..list.size-1)
            puts n
          end
          list[n].group = i
          list[n].save
          listNumbers.push(n)
        end
      end
    end
  end

  def distributed_users_in_groups
    self.started = true
    list = CompetitionUser.where(competition_id: self.id)
    if self.nGroups <= 1
      for i in 0..list.size-1
        list[i].group == 1
        list[i].save
      end
    else
      for i in 0..list.size-1
        for j in 0..self.nGroups-1
          list[i+j].group == j+1
          list[i+j].save
        end
        i+self.nGroups
      end
    end
    self.check_unbalanced_groups(list)

  end

  def check_unbalanced_groups(listCU)
    cont = 0

    #Nos creamos un array en el cual cada posición es el número de usuarios
    #por grupo
    arrayCont=[]
    for i in 0..self.nGroups-1
      for j in 0..listCU.size-1
        if listCU[j].group == i+1
          cont+=1
        end
      end
      arrayCont[i] = cont
    end

    self.balanced_groups(listCU, arrayCont)
  end

  def balanced_groups(list, arrayCont)
    cont = 1
    for i in 0..arrayCont.size-1
      if arrayCont[i] < self.nWinners+1
        for j in 0..list.size-1

          if list[j].group == i+1
            list[j].group = cont
            list[j].save
          end

          if cont == i
            cont +=1
            if cont > arrayCont.size-1
              cont = 1
            end
          else
            cont+=1
          end
        end
      end
    end
  end

end
