# Read justices from CSV file
JUSTICES_FILENAME = "db/justices.csv"
Justice.delete_all
csv = CSV.read(JUSTICES_FILENAME)
i = 1
while i < csv.length
  Justice.create(first_name: csv[i][0], last_name: csv[i][1], image_file: csv[i][2])
  i += 1
end
