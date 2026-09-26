using BookStoreService as service from '../../srv/service';
annotate service.Authors with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Book Details',
            ID : 'BookDetails',
            Target : '@UI.FieldGroup#BookDetails',
        },
    ],
    UI.FieldGroup #Ebook : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : content,
                Label : 'Ebook File',
            },
        ],
    },
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : name,
            Label : 'Author Name',
        },
    ],
    UI.FieldGroup #BookDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : bookCount,
                Label : 'Book Count',
            },
        ],
    },
);

