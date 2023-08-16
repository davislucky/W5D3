require_relative 'database.rb'

class QuestionLike

    attr_accessor :id, :user_id, :question_id

    def self.find_by_id(id)
        question_likes = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_likes
            WHERE
                id = ?
        SQL

        return nil if question_likes.empty?
        QuestionLike.new(question_likes.first)
    end

    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
    end

end
