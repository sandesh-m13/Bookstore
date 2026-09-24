sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"authorslistview/test/integration/pages/AuthorsList.gen",
	"authorslistview/test/integration/pages/AuthorsObjectPage.gen"
], function (JourneyRunner, AuthorsListGenerated, AuthorsObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('authorslistview') + '/test/flp.html#app-preview',
        pages: {
			onTheAuthorsListGenerated: AuthorsListGenerated,
			onTheAuthorsObjectPageGenerated: AuthorsObjectPageGenerated
        },
        async: true
    });

    return runner;
});

