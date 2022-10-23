using { sap.capire.bookshop as my } from '../db/schema';
service AdminService @(requires:'admin') {
  entity Books as projection on my.Books;
  entity Movies as projection on my.Movies;
  entity Authors as projection on my.Authors;
  entity Orders as select from my.Orders;
};

annotate AdminService.Books with @(

UI: {
  HeaderInfo  : {
      TypeName : '{i18n>Cat.TypeName}',
      TypeNamePlural : '{i18n>Cat.TypeNamePlural}',
      Title: { $Type: 'UI.DataField', Value: title }
  },
  SelectionFields  : [
      ID, author_ID, createdAt, price
  ],
  LineItem  : [
        {$Type: 'UI.DataField', Value: ID},
        {$Type: 'UI.DataField', Value: title},
        {$Type: 'UI.DataField', Value: author.name},
        {$Type: 'UI.DataField', Value: price},
        {$Type: 'UI.DataField', Value: stock}
  ]
}

);

annotate AdminService.Books with {
  ID @( Common: { Label: '{i18n>Cat.ProductID}'} );
  price @( Common.Label: '{i18n>Cat.ProductPrice}', Measures.ISOCurrency: currency_code );
}