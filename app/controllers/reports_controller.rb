class ReportsController < ApplicationController
  def users_and_tweets
    @report = Reports::RawReportService.users_and_tweets
    render json: @report
  end

  def companies_and_user_count
    @report = Reports::RawReportService.companies_and_user_count
    render json: @report
  end
end
