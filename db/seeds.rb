# Read justices from CSV file
JUSTICES_FILENAME = "db/justices.csv"
Justice.delete_all
Case.delete_all
Opinion.delete_all
Issue.delete_all

csv = CSV.read(JUSTICES_FILENAME)
i = 1
while i < csv.length
  Justice.create(first_name: csv[i][0], last_name: csv[i][1], image_file: csv[i][2])
  i += 1
end

marriage = Issue.create(name: "Same sex marriage")

justice_kennedy = Justice.find_by(last_name: "Kennedy")
justice_roberts = Justice.find_by(last_name: "Roberts")

obergefell = Case.create(name: "Obergefell v. Hodges", issue_id: marriage.id, date_decided: "2015-01-01")

o_kennedy = Opinion.create(case_id: obergefell.id, justice_id: justice_kennedy.id)
o_roberts = Opinion.create(case_id: obergefell.id, justice_id: justice_kennedy.id, opinion_type: "dissent")