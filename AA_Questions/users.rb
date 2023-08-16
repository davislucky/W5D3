require_relative 'database.rb'

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

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end
end


