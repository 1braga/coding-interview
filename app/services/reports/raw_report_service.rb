class Reports::RawReportService
  def self.users_and_tweets
    sql = <<-SQL
      SELECT users.id AS user_id,
             users.display_name AS user_name,
             tweets.id AS tweet_id,
             tweets.body,
             tweets.created_at AS tweet_date
      FROM users
      LEFT JOIN tweets ON tweets.user_id = users.id
      ORDER BY tweets.created_at DESC NULLS LAST
    SQL

    ActiveRecord::Base.connection.exec_query(sql).to_a
  end

  def self.companies_and_user_count
    sql = <<-SQL
      SELECT companies.id AS company_id,
             companies.name AS company_name,
             COUNT(users.id) AS users_count
      FROM companies
      LEFT JOIN users ON users.company_id = companies.id
      GROUP BY companies.id, companies.name
      ORDER BY users_count DESC
    SQL

    ActiveRecord::Base.connection.exec_query(sql).to_a
  end
end