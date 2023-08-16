require_relative 'database.rb'


class Question
    attr_accessor :id, :title, :body, :user_id

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
end

p question = Question.find_by_id(1)