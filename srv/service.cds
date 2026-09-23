using {tutorial.db as db} from '../db/schema';

service BookStoreService {
    entity Books      as projection on db.Books
                         //Bound Actions
        actions {
            action addStock();
            action changePublishDate(newDate: Date);
            action changeStatus( @(Common: {
                                     Label                   : 'New Status',
                                     ValueListWithFixedValues: true,
                                     ValueList               : {
                                         $Type         : 'Common.ValueListType',
                                         CollectionPath: 'StatusCode',
                                         Parameters    : [
                                             {
                                                 $Type            : 'Common.ValueListParameterInOut',
                                                 LocalDataProperty: newStatus,
                                                 ValueListProperty: 'code',
                                             },
                                             {
                                                 $Type            : 'Common.ValueListParameterDisplayOnly',
                                                 LocalDataProperty: newStatus,
                                                 ValueListProperty: 'statusText',
                                             },
                                         ],
                                     },
                                 })
                                 newStatus: String);
        };

    //Unbound Action
    @(Common.SideEffects: {TargetEntities: ['/BookStoreService.EntityContainer/Books']})
    action addDiscount();

    entity Authors    as projection on db.Authors;
    entity Chapters   as projection on db.Chapters;
    entity StatusCode as projection on db.StatusCode;

    entity GenreVH    as projection on db.Genres;

}

annotate BookStoreService.Books with @odata.draft.enabled;
