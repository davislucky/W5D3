require_relative 'database.rb'
require_relative 'questions.rb'
require_relative 'replies.rb'
require_relative 'question_follows.rb'

class User
    attr_accessor :id, :fname, :lname

    def self.find_by_id(id)
        users = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                users
            WHERE
                id = ?
        SQL

        return nil unless users.length > 0
        User.new(users.first)
    end

    def self.find_by_name(fname, lname)
        raise "Invalid name" if fname.nil? && lname.nil?
        users = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
            SELECT
                *
            FROM
                users
            WHERE
                fname = ? 
            AND
                lname = ?
        SQL
        users.map{|user| User.new(user)}
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def authored_questions
        Question.find_by_author_id(self.id)
    end

    def authored_replies
        Reply.find_by_user_id(self.id)
    end

    def followed_questions
        QuestionFollow.followed_questions_for_user_id(self.id)
    end
end

# p user = User.find_by_id(4)
# p user.followed_questions
# p User.find_by_id(1).followed_questions
# p user_inst.authored_questions
# p user_inst.authored_replies