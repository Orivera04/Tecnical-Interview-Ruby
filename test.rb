# 1. Crea un programa similar a un foro donde se registraran usuarios, preguntas y equipos
# 2. Define al menos 2 clases:
# 		1. User: nombre
# 		2. Question usuario y preguntas

class User
  attr_accessor :name

  def initialize(name)
    self.name = name
  end
end

class Question
  attr_accessor :question
  attr_accessor :user

  def initialize(question, user)
    self.question = question
    self.user = user
  end
end

class Team < Array

  def <<(team)
    super(team)
    self
  end
end

class Forum
  attr_accessor :questions

  def initialize(questions)
    self.questions = questions
  end

  def questions_by(team)
    questions = []

    if team.is_a?(Team)
      questions = []
      self.questions.each do |question|
        team.each do |user|
          if question.user.name == user.name
            questions << question
          end
        end
      end
        questions
    else
      self.questions.select{|user| user.user == team }
    end
  end

  def scoreboard
    questions.group_by(&:user).keys.sort_by(&:name)
  end
end

david = User.new("David")
geovany = User.new("Geovany")
ariel = User.new("Ariel")

p david.name == "David" # => true
p geovany.name == "Geovany" # => true
p ariel.name == "Ariel" # => true


##############################################

q1 = Question.new("Primera pregunta", david)
q2 = Question.new("Segunda pregunta", geovany)
q3 = Question.new("Tercera pregunta", ariel)
q4 = Question.new("Cuarta pregunta", ariel)
q5 = Question.new("Quinta pregunta", ariel)
q6 = Question.new("Sexta pregunta", david)

p q1.question == "Primera pregunta" # => true
p q1.user == david # => true

##############################################



# 3. Crear la clase Team y Forum
#   - Para la clase Team serán asignados los usuarios
#   - Para la clase Forum recibirá las preguntas
# 4. Determinar si las preguntas fueron realizadas por un equipo o un usuario

team = Team.new
team << david
team << geovany

team2 = Team.new
team2 << ariel


forum = Forum.new([q1, q2, q3, q4, q5, q6])

p forum.questions_by(team) ==  [q1, q2, q6] # => true
p forum.questions_by(ariel) == [q3, q4, q5] # => true

p forum.scoreboard() == [ariel, david, geovany] # => true
