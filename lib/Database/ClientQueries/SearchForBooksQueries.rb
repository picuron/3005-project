require 'pg'
require 'io/console'
require_relative '../GenStatements.rb'

module Client
  class SearchForBooksQueries
    def initialize(con, cart)
      @con = con
      @cart = cart
    end


    def books_by_similar_value(key, value)
      #This part is complex because the user will submit and author_name, but we store first_name and last_name
      #In the db, so we need to concatenate these columns, then query over that.
      #This will allows for multiple book copies, incase the similarly spelled authors are different people, 
      #but still worked on the same book.
      if (key) == ('author_name')
        statement =  "WITH subQuery AS("\
          "SELECT concat_ws(' ', first_name, last_name) AS author_name, isbn, title "\
            "FROM book "\
            "JOIN author_books USING(isbn) "\
            "JOIN author USING(a_id) "\
            "JOIN author_email ON author.email_address = author_email.email_address "\
            "JOIN publisher USING(p_id) "\
            "JOIN publisher_email ON publisher.email_address = publisher_email.email_address "\
          ")"\
        "SELECT "\
          "title, "\
          "isbn, "\
          "author_name, "\
          "(100 - LEVENSHTEIN(UPPER(author_name), UPPER($1))) AS similarity_score "\
          "FROM subQuery "\
          "ORDER BY similarity_score DESC "\
          "LIMIT 5"
          @con.exec_params(statement, [value])
      else
        #This is complicated because otherwise we get multiple joins since there can be many authors 
        #to just 1 book, so the ranking similarity would display the same book 5 times, if it had 5 authors
        statement = "WITH subQuery AS("\
        "SELECT DISTINCT ON(title) "\
          "title, "\
          "isbn, "\
          "#{key} AS requested_field_#{key} "\
          "FROM book "\
          "JOIN author_books USING(isbn) "\
          "JOIN author USING(a_id) "\
          "JOIN author_email ON author.email_address = author_email.email_address "\
          "JOIN publisher USING(p_id) "\
          "JOIN publisher_email ON publisher.email_address = publisher_email.email_address "\
          "ORDER BY title"\
        ")"\
        "SELECT "\
          "title, "\
          "isbn, "\
          "requested_field_#{key}, "\
          "(100 - LEVENSHTEIN(UPPER(#{key}), UPPER($1))) AS similarity_score "\
          "FROM subQuery "\
          "ORDER BY similarity_score DESC "\
          "LIMIT 5"
        @con.exec_params(statement, [value])
      end
    end

  end
end