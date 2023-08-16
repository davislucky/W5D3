require_relative 'database.rb'
require_relative 'users.rb'

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

    def self.followers_for_question_id(question_id)
        users = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT 
                users.id, users.fname, users.lname 
            FROM 
                users
            JOIN 
                question_follows
            ON 
                users.id = question_follows.user_id
            WHERE
                question_id = ?
        SQL

        users.map {|user| User.new(user)}

    end

    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
    end
    
end

p QuestionFollow.followers_for_question_id(2)
