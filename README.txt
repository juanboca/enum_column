Overview

  This gem is a fork from http://github.com/electronick/enum_column
  The types of the enumerated values were changed to strings.

  This gem is an extension to ActiveRecord which enables native support of enumerations in the database schema using the ENUM type in MySQL.
  Currently only MySQL is implemented.
  Tested with Rails 3, for Rails 2 you should better use enum-column plugin (http://rubyforge.org/projects/enum-column/)
  Works with Scaffolding.

  Supported adapters:
    mysql
    mysql2
    jdbcmysql (by Nilesh Trivedi)

How to use it.

In you Gemfile:

  gem 'enum_column3'

In your schema:

  When you create your schema, specify the constraint as a limit:

    create_table :enumerations, :force => true do |t|
      t.column :severity, :enum, :limit => [:low, :medium, :high, :critical], :default => :medium
      t.column :color, :enum, :limit => [:red, :blue, :green, :yellow]
      ...
    end

In a migration:

    def up
      change_column :table_name, :sex, :enum, :limit => ['Male','Female','Unknown'], :default => 'Unknown'
    end

In the model:

  You can then automatically validate this column using:

    validates_columns :severity, :color

  The rest will be handled for you. All enumerated values will be given as strings.

    @e = Enumeration.new
    @e.severity = :medium

You can always use the column reflection to get the list of possible values from the database column.

    Enumeration.columns_hash['color'].limit
    or
    @enumeration.column_for_attribute(:color).limit

    Will yield: [:red, :blue, :green, :yellow]


In views:

  You can use enum_select helper to generate input for enumerated attribute as:

     <%= enum_select(@enumeration, 'severity')%>
     or
     <%= form_for @enumeration do |f| %>
        <%= f.label :severity %>
        <%= f.enum_select :severity %>
     <% end %>

