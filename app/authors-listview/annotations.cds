using BookStoreService as service from '../../srv/service';
annotate service.Authors with @(
    UI.Facets : [
        
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
);

