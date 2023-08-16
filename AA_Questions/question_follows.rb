require_relative 'database.rb'

class QuestionFollow

    attr_accessor :id, :user_id, :question_id

    def self.find_by_id(id)
        question_follows = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_follows
            WHERE
                id = ?
        SQL

        return nil if question_follows.empty?
        QuestionFollow.new(question_follows.first)
    end

    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
    end
    

end
