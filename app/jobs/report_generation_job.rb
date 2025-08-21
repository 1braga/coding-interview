class ReportGenerationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    generate_users_tweets_report
    generate_companies_users_report
  end

  private

  #usuários e seus tweets, ordenados por data de criação
  def generate_users_tweets_report
    users = User.includes(:tweets).order(:created_at)

    report_data = users.map do |user|
      {
        user_id: user.id,
        username: user.username,
        tweets: user.tweets.order(:created_at).map { |t| { id: t.id, body: t.body, created_at: t.created_at } }
      }
    end

    File.open("tmp/users_tweets_report.json", "w") do |f|
      f.write(report_data.to_json)
    end

    Rails.logger.info "Relatório de usuários e tweets gerado!"
  end

  #número de usuários associados a cada empresa
  def generate_companies_users_report
    companies = Company.left_joins(:users).group("companies.id").select("companies.*, COUNT(users.id) as users_count")

    report_data = companies.map do |company|
      {
        company_id: company.id,
        name: company.name,
        users_count: company.users_count
      }
    end

    File.open("tmp/companies_users_report.json", "w") do |f|
      f.write(report_data.to_json)
    end

    Rails.logger.info "Relatório de empresas e usuários gerado!"
  end
end

