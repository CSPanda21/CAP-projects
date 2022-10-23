using { sap.capire.bookshop as my } from '../db/schema';
// @impl: './cat-service.js'
service CatalogService @(path:'/browse') {

  @readonly entity Books as SELECT from my.Books {*,
    author.name as author
  } excluding { createdBy, modifiedBy };

  @requires_: 'authenticated-user'
  entity Orders as projection on my.Orders;
}

annotate Catalogservice.Orders with @(restrict: [
  {grant: 'READ', to: 'authenticated-user', where: 'createdBy = $user'},
  {grant: 'UPDATE', to: 'authenticated-user', where: 'createdBy = $user'}
]);
