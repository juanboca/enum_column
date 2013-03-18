# This module provides all the column helper methods to deal with the
# values and adds the common type management code for the adapters.


# try rails 3.1, then rails 3.2+, mysql column adapters
column_class = if defined? ActiveRecord::ConnectionAdapters::Mysql2Column
  ActiveRecord::ConnectionAdapters::Mysql2Column
elsif defined? ActiveRecord::ConnectionAdapters::MysqlColumn
  ActiveRecord::ConnectionAdapters::MysqlColumn
elsif defined? ActiveRecord::ConnectionAdapters::Mysql2Adapter::Column
  ActiveRecord::ConnectionAdapters::Mysql2Adapter::Column
elsif defined? ActiveRecord::ConnectionAdapters::MysqlAdapter::Column
  ActiveRecord::ConnectionAdapters::MysqlAdapter::Column
else
  ObviousHint::NoMysqlAdapterFound
end

column_class.module_eval do

private
  alias __simplified_type_enum simplified_type
  # The enum simple type.
  def simplified_type(field_type)
    if field_type =~ /enum/i
      :enum
    else
      __simplified_type_enum(field_type)
    end
  end

  alias __extract_limit_enum extract_limit
  def extract_limit(sql_type)
    if sql_type =~ /^enum/i
      sql_type.sub(/^enum\('(.+)'\)/i, '\1').split("','").map { |v| v.intern }
    else
      __extract_limit_enum(sql_type)
    end
  end

end
