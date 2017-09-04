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
  mount_uploader :avatar_competition, AvatarCompetitionUploader



  def real_winners
    return self.nGroups*self.nWinners
  end
  def finish_competition
    self.finished = true
    self.save
    CompetitionMailer.send_end_competition(self.users, self)
  end

  def start_competition_regular
    self.distributed_users_in_groups(self.users)
    self.started = true
    self.save
    CompetitionMailer.send_start_competition(self.users, self)
  end

  def start_competition_playoff
    self.started = true
    self.save
    CompetitionMailer.send_start_competition_plaoff(self.users, self)
  end

  def import_winners(competitionToImport)

    #lista de inscripciones resultante, con los ganadores importados ya inscritos
    listEnrollsWinners = []

    #Objeto competición para saber el nº de ganadores que tenía la competición
    #de la cual estamos importándolos
    @competitionToImport = competitionToImport

    #lista de inscripciones de la competición a importar sus ganadores
    if @competitionToImport.type_competition == "classification"
      listEnrolls = CompetitionUser.where(competition_id: self.idCompImportWinners).order(score: :desc)
    else
      listEnrolls = CompetitionUser.where(competition_id: self.idCompImportWinners).order(score: :asc)
    end

    n = @competitionToImport.nGroups
    m = @competitionToImport.nWinners
    l = listEnrolls.size

    #Si el número de grupos de la competición a importar es 1, se inscriben directamente
    #los ganadores. Si no, se recorre el vector y se guardan los primeros que se
    #encuentren de cada grupo (Por que los primeros son los que tienen mayor score,
    #ya que están ordenados descencentemente por score)
    if n == 1
      #Sacamos los ganadores de la competición a importar y  los inscribimos
      #en la que se está creando
      for i in 1..m
        userId = listEnrolls[i-1].user_id
        enrollUser = CompetitionUser.new(competition_id: self.id, user_id: userId)
        enrollUser.save
        listEnrollsWinners.push(enrollUser)
      end
    else
      (1..n).each do |i|
        cont = 0
        for j in 0..l-1
          if listEnrolls[j].group == i && cont < m
            cont += 1
            userId = listEnrolls[j].user_id
            enrollUser = CompetitionUser.new(competition_id: self.id, user_id: userId)
            enrollUser.save
            listEnrollsWinners.push(enrollUser)
          end
          if cont == m
            break
          end
        end
      end
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
        list[i].group = 1
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


  def distributed_users_in_groups(users)
    @competition_users = []
    users.each do |user|
      @user = user
      @competition_user = CompetitionUser.where(competition_id: self.id, user_id: @user.id).first
      @competition_users.push(@competition_user)
    end

    n = @competition_users.size-1
    if self.nGroups == 1
      for i in 0..n
        @competition_users[i].group = 1
        @competition_users[i].save
      end
    else
      i = 0
       while (i <= n)
        for j in 0..self.nGroups-1
          if i+j <= n
            puts "i=#{i} , j=#{j}"
            @competition_users[i+j].group = j+1
            puts @competition_users[i+j].group
            @competition_users[i+j].save
          end
        end
        if  i+self.nGroups > n
          i += 1
        else
          i += self.nGroups
        end
      end
    end

    self.check_unbalanced_groups(@competition_users)

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
