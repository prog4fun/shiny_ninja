# encoding: UTF-8

module ProjectsHelper

  def get_proportion_of_project_and_report_duration_in_percent(project)
    sum_report_duration = sum_of_duration(project.reports_worked)

    percent = ((sum_report_duration / project.timebudget) * 100).round
    percent > 100 ? (return 100) : (return percent)
  end
end
