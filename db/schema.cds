using {
  cuid,
  managed
} from '@sap/cds/common';

namespace tutorial.db;

entity Books : cuid, managed {
  title       : String; //always use lowercase for property names
  author      : Association to Authors;
  genre       : String;
  publishedAt : Date;
  pages       : Integer;
  price       : Decimal(9, 2);
  Chapters    : Composition of many Chapters //Uppercase property name for compositions only
                  on Chapters.book = $self;
}

entity Authors : cuid, managed {
  name  : String;
  books : Association to many Books
            on books.author = $self;
}

entity Chapters : cuid, managed {
  key book   : Association to Books;
      number : Integer;
      title  : String;
      pages  : Integer;
}
