global with sharing class CP_SiteLoginController {

    //set username/ password variables via page
    global String username {get; set;}
    global String password {get; set;}
    global Boolean rememberUsername {get; set;}

    global PageReference login() {

        //static org-id and portal id
        String strOrgID = '00Di0000000Hr2k';
        String strPortalID = '060i0000000D3nV';
        String strURL = 'https://na15.salesforce.com';
        //String strURL = System.currentPageReference().getParameters().get('startURL');
        System.Debug('-------------------------> strURL = ' + strURL);

        //start url of the page
        String startUrl = strUrl + '/secur/login_portal.jsp?orgId=' + strOrgID + '&portalId=' + strPortalID;


        startUrl += '&un=' + username;
        startUrl += '&pw='+ password;
        System.Debug('---------------------------> startURL = ' + startURL);

        //set reference and attempt login
        PageReference portalPage = new PageReference(startUrl);
        portalPage.setRedirect(true);
        PageReference p = Site.login(username, password, startUrl);

        //if p==null, no login
        if (p == null) {
            return Site.login(username, password, null);
        } else {
            return portalPage;
        }
    }


    //test data provided by salesforce
    global CP_SiteLoginController () {}

    @IsTest(SeeAllData=true) global static void testCPSiteLoginController () {
    // Instantiate a new controller with all parameters in the page
    CP_SiteLoginController controller = new CP_SiteLoginController ();
    controller.username = 'test@salesforce.com';
    controller.password = '123456';

    System.assertEquals(controller.login(),null);
    }


}