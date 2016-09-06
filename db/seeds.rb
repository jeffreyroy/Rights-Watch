# Read justices from CSV file
JUSTICES_FILENAME = "db/justices.csv"
CASES_FILENAME = "db/cases.csv"
ISSUES_FILENAME = "db/issues.csv"
Justice.delete_all
Case.delete_all
Opinion.delete_all
Issue.delete_all

csv = CSV.read(ISSUES_FILENAME)
i = 1
while i < csv.length
  Issue.create(name: csv[i][0])
  i += 1
end

csv = CSV.read(JUSTICES_FILENAME)
i = 1
while i < csv.length
  Justice.create(first_name: csv[i][0], last_name: csv[i][1], image_file: csv[i][2])
  i += 1
end

csv = CSV.read(CASES_FILENAME)
i = 1
while i < csv.length
  issue=Issue.find_by(name: csv[i][4])
  Case.create(name: csv[i][0], date_decided: csv[i][1], cite1: csv[i][2])
  i += 1
end


justice_kennedy = Justice.find_by(last_name: "Kennedy")
justice_roberts = Justice.find_by(last_name: "Roberts")

obergefell = Case.find_by(name: "Obergefell v. Hodges")

o_kennedy = Opinion.create(case_id: obergefell.id, justice_id: justice_kennedy.id)
o_roberts = Opinion.create(case_id: obergefell.id, justice_id: justice_kennedy.id, opinion_type: "dissent")
