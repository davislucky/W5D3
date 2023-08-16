require_relative 'database.rb'

class Reply

    attr_accessor :id, :body, :user_id, :question_id, :parent_reply_id

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

    def initialize(options)
        @id = options['id']
        @body = options['body']
        @user_id = options['user_id']
        @question_id = options['question_id']
        @parent_reply_id = options['parent_reply_id']
    end
    
end