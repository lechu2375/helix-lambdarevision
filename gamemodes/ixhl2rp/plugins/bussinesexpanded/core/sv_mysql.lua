function ix.db.LoadTables()
	local query 
	query = mysql:Create("business")
		query:Create("business_id", "INT(11) UNSIGNED NOT NULL AUTO_INCREMENT")
		query:Create("business_name", "INT(11) UNSIGNED NOT NULL")
		query:Create("business_owner", "INT(11) UNSIGNED NOT NULL")
		query:Create("business_desc", "VARCHAR(150) NOT NULL")
		query:PrimaryKey("business_id")
	query:Execute()
end

