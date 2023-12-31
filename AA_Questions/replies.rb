require_relative 'database.rb'

class Reply

    attr_accessor :id, :body, :user_id, :question_id, :parent_reply_id

    def self.find_by_user_id(user_id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                *
            FROM
                replies
            WHERE
                user_id = ?
        SQL
        replies.map { |reply| Reply.new(reply) }
    end

    def self.find_by_id(id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                replies
            WHERE
                id = ?
        SQL

        return nil if replies.empty?
        Reply.new(replies.first)
    end

    def self.find_by_question_id(question_id)
        replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                *
            FROM
                replies
            WHERE
                question_id =?
        SQL
        replies.map {|reply| Reply.new(reply)}
    end

    def initialize(options)
        @id = options['id']
        @body = options['body']
        @user_id = options['user_id']
        @question_id = options['question_id']
        @parent_reply_id = options['parent_reply_id']
    end 

    def author
        self.user_id
    end

    def question
        self.question_id
    end

    def parent_reply
        self.parent_reply_id
    end

    def child_replies
        replies = QuestionsDatabase.instance.execute(<<-SQL, self.id)
            SELECT
                *
            FROM
                replies
            WHERE
                parent_reply_id = ?
        SQL
        replies.map {|reply| Reply.new(reply)}
    end

end

# p Reply.find_by_question_id(1)[0].child_replies