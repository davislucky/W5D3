require_relative 'database.rb'
require_relative 'replies.rb'


class Question
    attr_accessor :id, :title, :body, :user_id

    def self.find_by_author_id(user_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                *
            FROM
                questions
            WHERE
                user_id = ?
        SQL
        return nil if questions.empty?
        questions.map { |question| Question.new(question) } 
    end

    def self.find_by_id(id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                questions
            WHERE
                id = ?
        SQL

        return nil unless questions.length > 0
        Question.new(questions.first)
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @user_id = options['user_id']
    end

    def author 
        self.user_id
    end

    def replies
        Reply.find_by_question_id(self.id)
    end
end





