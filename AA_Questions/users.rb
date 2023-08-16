require_relative 'database.rb'
require_relative 'questions.rb'
require_relative 'replies.rb'

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
        questions = Question.find_by_author_id(self.id)
        user_dup = self.dup
        user_dup['questions'] = questions
        user_dup
    end

    def authored_replies
        replies = Reply.find_by_user_id(self.id)
        user_dup = self.dup
        user_dup['replies'] = replies
        user_dup
    end
end

user_inst = User.find_by_id(1)
p user_inst.authored_questions